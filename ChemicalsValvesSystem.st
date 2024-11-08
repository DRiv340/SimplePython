PROGRAM program2
  VAR
    timerCoV : TON;
    timerChlV : TON;
  END_VAR
  VAR
    cycleOn AT %QX0.0 : BOOL;
    stop AT %QX0.1 : BOOL;
  END_VAR
  VAR
    turnOffCoagV1 : BOOL;
  END_VAR
  VAR
    CoagulationV AT %IX0.0 : BOOL;
    ChlorineV AT %IX0.1 : BOOL;
    FluoridationV AT %IX0.2 : BOOL;
  END_VAR
  VAR
    timerChFl3 : TON;
    timerfFL2 : TON;
    turnOffCoagChV : BOOL;
  END_VAR

  CoagulationV := NOT(turnOffCoagV1) AND NOT(FluoridationV) AND cycleOn;
  timerCoV(IN := CoagulationV AND cycleOn, PT := T#10000ms);
  ChlorineV := timerCoV.Q;
  IF turnOffCoagChV THEN
    ChlorineV := FALSE; (*reset*)
  END_IF;
  IF turnOffCoagChV THEN
    CoagulationV := FALSE; (*reset*)
  END_IF;
  timerChlV(IN := CoagulationV AND ChlorineV AND cycleOn, PT := T#5000ms);
  IF timerChlV.Q THEN
    turnOffCoagV1 := TRUE; (*set*)
  END_IF;
  FluoridationV := turnOffCoagV1 AND cycleOn AND NOT(ChlorineV) AND NOT(CoagulationV);
  timerChFl3(IN := cycleOn AND FluoridationV, PT := T#20000ms);
  IF timerChFl3.Q THEN
    FluoridationV := FALSE; (*reset*)
  END_IF;
  ChlorineV := timerChFl3.Q;
  timerfFL2(IN := cycleOn AND NOT(CoagulationV) AND ChlorineV, PT := T#5000ms);
  IF timerfFL2.Q THEN
    ChlorineV := FALSE; (*reset*)
  END_IF;
  IF timerfFL2.Q THEN
    turnOffCoagV1 := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    CoagulationV := FALSE; (*reset*)
  END_IF;
  IF stop AND stop THEN
    ChlorineV := FALSE; (*reset*)
  END_IF;
  IF stop OR stop THEN
    FluoridationV := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    cycleOn := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    turnOffCoagV1 := FALSE; (*reset*)
  END_IF;
  turnOffCoagChV := timerChlV.Q;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : program2;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "878f7d9fb32748457a5dd6f3a9cc7100";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern PROGRAM2 RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCOV.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHLV.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CYCLEON), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STOP), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TURNOFFCOAGV1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.COAGULATIONV), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CHLORINEV), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.FLUORIDATIONV), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERCHFL3.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERFFL2.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TURNOFFCOAGCHV), BOOL_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               47*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return sizeof(SINT);*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return sizeof(TIME);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_SINT_t *) ptr)->value;*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case TIME_ENUM:*)
(*DBG:        return (void *)&((__IEC_TIME_t *) ptr)->value;*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case SINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_SINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_SINT_t *) ptr)->value = *((SINT *) val);*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case TIME_ENUM: {*)
(*DBG:            memcpy(&((__IEC_TIME_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_TIME_t *) ptr)->value = *((TIME *) val);*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case SINT_ENUM:*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case TIME_ENUM:*)
(*DBG:            ((__IEC_TIME_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)