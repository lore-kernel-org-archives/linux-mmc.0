From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v1 1/4] trace_events: Add trace_print_register to print
 register fields
Date: Fri, 12 Apr 2019 09:30:36 -0600
Message-ID: <20190412153036.GB101407@google.com>
References: <20190411220822.81845-1-rrangel@chromium.org>
 <20190411220822.81845-2-rrangel@chromium.org>
 <20190411183934.28e6ad65@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411183934.28e6ad65@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 11, 2019 at 06:39:34PM -0400, Steven Rostedt wrote:
> On Thu, 11 Apr 2019 16:08:19 -0600
> Raul E Rangel <rrangel@chromium.org> wrote:
> 
> > This is a hybrid method that combines the functionality of
> > trace_print_flags_seq and trace_print_symbols_seq. It supports printing
> > bit fields, enum fields, and numeric fields.
> > 
> > Given the following register definition:
> >   * 0   - Enabled
> >   * 1   - Width, 0 = 1-bits, 1 = 4-bits
> >   * 2:3 - DMA, 0 = None, 1 = SDMA, 2 = ADMA, 3 = ADMA2
> >   * 4:7 - Timeout Counter
> > 
> > The register fields could be defined as follows:
> > 
> >   const struct trace_print_field reg[] = {
> >     {1<<0, "ENABLED"},
> >     {
> >       .mask = 1<<1,
> >       .name = "WIDTH",
> >       .symbols = (const struct trace_print_flags[]) {
> >         {0, "1-BIT"},
> >         {1, "4-BIT"},
> >         {}
> >       }
> >     }, {
> >       .mask = 3<<2,
> >       .symbols = (const struct trace_print_flags[]) {
> >         {0, "NONE"},
> >         {1, "SDMA"},
> >         {2, "ADMA"},
> >         {3, "ADMA2"},
> >         {}
> >       }
> >     },
> >     {0xF<<4, "TIMEOUT"}
> >   }
> > 
> > This would print out the following given value 0xAB:
> > 
> > ENABLED: 1 | WIDTH: 4-BIT | ADMA | TIMEOUT: 0xA
> > 
> 
> Note the rational for the __print_symbolic and __print_flags is that
> they show how to translate into something that perf and trace-cmd can
> read from userspace.

Ah, I wasn't aware that the format was exposed via sysfs. That makes
sense why the macros are used. I was using xhci-trace as my reference
point which just calls arbitrary functions.

cat /sys/kernel/debug/tracing/events/xhci-hcd/xhci_handle_event/format
print fmt: "%s: %s",
xhci_ring_type_string(REC->type),
xhci_decode_trb(REC->field0, REC->field1, REC->field2, REC->field3)

I'm guessing calling out to a function is not the way the framework was
intended to be used. Does this mean that every TRB type in xhci_decode_trb
should be its own trace event so the printf format isn't hidden inside
the code?

> 
> How does perf or trace-cmd parse this? To add something like this, you
> need them to have the same output as what is displayed by the trace
> file otherwise NAK.

So for the short term I can remove __print_register. The SDHCI tracing
doesn't use it, but instead calls out to a method that calls
trace_print_register directly. Or I could move trace_print_register
into the sdhci-trace module.

cat /sys/kernel/debug/tracing/events/sdhci/sdhci_read/format

print fmt: "%s: %#x [%s] => %#x: %s",
  __get_str(name),
  REC->reg,
  __print_symbolic(REC->reg & ~3UL, {0x00, "DMA_ADDRESS"}, ...),
  REC->val,
  sdhci_decode_register( p, REC->reg, REC->val, REC->mask )

The format prints out the raw value, so using perf or trace-cmd
will still have value, you just won't get the pretty print.

For the long term I could make event-parser handle __print_register. I'm
assuming it just needs to handle the additional case?
https://github.com/torvalds/linux/blob/master/tools/lib/traceevent/event-parse.c#L3040

Thanks for the feedback,
Raul

> 
> -- Steve
> 
> 
> > See https://pastebin.com/x73d5cvL for this in action.
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > 
> >  include/linux/trace_events.h    |   4 ++
> >  include/linux/tracepoint-defs.h |   6 ++
> >  include/trace/trace_events.h    |   9 +++
> >  kernel/trace/trace_output.c     | 121 ++++++++++++++++++++++++++++++++
> >  4 files changed, 140 insertions(+)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 8a62731673f7..3c44909ce8b3 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -23,6 +23,10 @@ const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
> >  const char *trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
> >  				    const struct trace_print_flags *symbol_array);
> >  
> > +const char *trace_print_register(struct trace_seq *p,
> > +				 const struct trace_print_field fields[],
> > +				 unsigned long val, unsigned long mask);
> > +
> >  #if BITS_PER_LONG == 32
> >  const char *trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
> >  		      unsigned long long flags,
> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > index 49ba9cde7e4b..c3dc27c192f4 100644
> > --- a/include/linux/tracepoint-defs.h
> > +++ b/include/linux/tracepoint-defs.h
> > @@ -16,6 +16,12 @@ struct trace_print_flags {
> >  	const char		*name;
> >  };
> >  
> > +struct trace_print_field {
> > +	unsigned long			mask;
> > +	const char			*name;
> > +	const struct trace_print_flags	*symbols;
> > +};
> > +
> >  struct trace_print_flags_u64 {
> >  	unsigned long long	mask;
> >  	const char		*name;
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index 4ecdfe2e3580..6adc32fcb1c3 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -300,6 +300,14 @@ TRACE_MAKE_SYSTEM_STR();
> >  		trace_print_symbols_seq(p, value, symbols);		\
> >  	})
> >  
> > +#undef __print_register
> > +#define __print_register(value, mask, field_array...)			\
> > +	({								\
> > +		static const struct trace_print_field fields[] =	\
> > +			{ field_array, {} };			\
> > +		trace_print_register(p, value, mask, fields);		\
> > +	})
> > +
> >  #undef __print_flags_u64
> >  #undef __print_symbolic_u64
> >  #if BITS_PER_LONG == 32
> > @@ -744,6 +752,7 @@ static inline void ftrace_test_probe_##call(void)			\
> >  
> >  #undef __print_flags
> >  #undef __print_symbolic
> > +#undef __print_register
> >  #undef __print_hex
> >  #undef __print_hex_str
> >  #undef __get_dynamic_array
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index 54373d93e251..cd5727ad54c3 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -124,6 +124,127 @@ trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
> >  }
> >  EXPORT_SYMBOL(trace_print_symbols_seq);
> >  
> > +/**
> > + * trace_print_register - Prints all the fields of a register.
> > + *
> > + * This is a hybrid method that combines the functionality of
> > + * trace_print_flags_seq and trace_print_symbols_seq. It supports printing
> > + * bit fields, enum fields, and numeric fields.
> > + *
> > + * Given the following register definition:
> > + *   * 0   - Enabled
> > + *   * 1   - Width, 0 = 1-bits, 1 = 4-bits
> > + *   * 2:3 - DMA, 0 = None, 1 = SDMA, 2 = ADMA, 3 = ADMA2
> > + *   * 4:7 - Timeout Counter
> > + *
> > + * The register fields could be defined as follows:
> > + *
> > + *   const struct trace_print_field reg[] = {
> > + *     {1<<0, "ENABLED"},
> > + *     {
> > + *       .mask = 1<<1,
> > + *       .name = "WIDTH",
> > + *       .symbols = (const struct trace_print_flags[]) {
> > + *         {0, "1-BIT"},
> > + *         {1, "4-BIT"},
> > + *         {}
> > + *       }
> > + *     }, {
> > + *       .mask = 3<<2,
> > + *       .symbols = (const struct trace_print_flags[]) {
> > + *         {0, "NONE"},
> > + *         {1, "SDMA"},
> > + *         {2, "ADMA"},
> > + *         {3, "ADMA2"},
> > + *         {}
> > + *       }
> > + *     },
> > + *     {0xF<<4, "TIMEOUT"}
> > + *   }
> > + *
> > + * This would print out the following given value 0xAB:
> > + *
> > + * ENABLED: 1 | WIDTH: 4-BIT | ADMA | TIMEOUT: 0xA
> > + *
> > + * @p: trace buffer
> > + * @fields: Array of fields that describe the register. Must be terminated with
> > + *          an empty value.
> > + * @val: register value
> > + * @mask: Mask that defines the bits present in @val. Useful if only a subset
> > + *        of the register was read. Any fields that fall outside of the mask
> > + *        will not be printed.
> > + */
> > +const char *trace_print_register(struct trace_seq *p,
> > +				 const struct trace_print_field fields[],
> > +				 unsigned long val, unsigned long mask)
> > +{
> > +	const char *ret = trace_seq_buffer_ptr(p);
> > +	char *tail;
> > +	unsigned long fval;
> > +	int first = 1, symbol_found;
> > +	const struct trace_print_field *field;
> > +	const struct trace_print_flags *symbol;
> > +
> > +	for (field = fields; field->mask; field++) {
> > +		/* Make sure the field mask is within the accessed bits */
> > +		if ((mask & field->mask) != field->mask)
> > +			continue;
> > +
> > +		if (!first)
> > +			trace_seq_puts(p, " | ");
> > +
> > +		first = 0;
> > +
> > +		if (field->name) {
> > +			trace_seq_puts(p, field->name);
> > +			trace_seq_puts(p, ": ");
> > +		}
> > +
> > +		fval = val & field->mask;
> > +		fval >>= ffs(field->mask) - 1;
> > +
> > +		val &= ~field->mask;
> > +
> > +		symbol_found = 0;
> > +		for (symbol = field->symbols; symbol && symbol->name;
> > +		     symbol++) {
> > +			if (symbol->mask != fval)
> > +				continue;
> > +			trace_seq_puts(p, symbol->name);
> > +			symbol_found = 1;
> > +			break;
> > +		}
> > +
> > +		if (!symbol_found) {
> > +			if (fval == 0) {
> > +				trace_seq_puts(p, "0");
> > +			} else if (fval == 1) {
> > +				trace_seq_puts(p, "1");
> > +			} else {
> > +				trace_seq_printf(p, "%#x", fval);
> > +
> > +				/* Strip off the null terminator */
> > +				for (tail = trace_seq_buffer_ptr(p) - 1;
> > +				     tail > ret && !*tail; tail--) {
> > +					p->seq.len--;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	/* Print any left over bits */
> > +	if (val) {
> > +		if (!first)
> > +			trace_seq_puts(p, " | ");
> > +		trace_seq_printf(p, "%#x", val);
> > +	}
> > +
> > +	trace_seq_putc(p, 0);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(trace_print_register);
> > +
> >  #if BITS_PER_LONG == 32
> >  const char *
> >  trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
> 
