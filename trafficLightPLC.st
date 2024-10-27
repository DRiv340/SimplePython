PROGRAM program2
  VAR
    timerRed : TON;
    timerRedAmb : TON;
  END_VAR
  VAR
    cycleOn AT %QX0.0 : BOOL;
    stop AT %QX0.1 : BOOL;
  END_VAR
  VAR
    turnOffRed : BOOL;
  END_VAR
  VAR
    red AT %IX0.0 : BOOL;
    amber AT %IX0.1 : BOOL;
    green AT %IX0.2 : BOOL;
  END_VAR
  VAR
    timerGreen : TON;
    timerAmber : TON;
    turnOffRedAmber : BOOL;
  END_VAR

  red := NOT(turnOffRed) AND NOT(green) AND cycleOn;
  timerRed(IN := red AND cycleOn, PT := T#10000ms);
  amber := timerRed.Q;
  IF turnOffRedAmber THEN
    amber := FALSE; (*reset*)
  END_IF;
  IF turnOffRedAmber THEN
    red := FALSE; (*reset*)
  END_IF;
  timerRedAmb(IN := red AND amber AND cycleOn, PT := T#5000ms);
  IF timerRedAmb.Q THEN
    turnOffRed := TRUE; (*set*)
  END_IF;
  green := turnOffRed AND cycleOn AND NOT(amber) AND NOT(red);
  timerGreen(IN := cycleOn AND green, PT := T#20000ms);
  IF timerGreen.Q THEN
    green := FALSE; (*reset*)
  END_IF;
  amber := timerGreen.Q;
  timerAmber(IN := cycleOn AND NOT(red) AND amber, PT := T#5000ms);
  IF timerAmber.Q THEN
    amber := FALSE; (*reset*)
  END_IF;
  IF timerAmber.Q THEN
    turnOffRed := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    red := FALSE; (*reset*)
  END_IF;
  IF stop AND stop THEN
    amber := FALSE; (*reset*)
  END_IF;
  IF stop OR stop THEN
    green := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    cycleOn := FALSE; (*reset*)
  END_IF;
  IF stop THEN
    turnOffRed := FALSE; (*reset*)
  END_IF;
  turnOffRedAmber := timerRedAmb.Q;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : program2;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "d840b0ad44c5f1b107c57c7d080b94f7";*)
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
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERRED.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERREDAMB.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CYCLEON), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STOP), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TURNOFFRED), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RED), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.AMBER), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.GREEN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERGREEN.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.PT), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.ET), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.STATE), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.PREV_IN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.CURRENT_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TIMERAMBER.START_TIME), TIME_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TURNOFFREDAMBER), BOOL_ENUM},*)
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