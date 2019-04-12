From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/4] trace_events: Add trace_print_register to print
 register fields
Date: Fri, 12 Apr 2019 11:42:00 -0400
Message-ID: <20190412114200.6c1a8593@gandalf.local.home>
References: <20190411220822.81845-1-rrangel@chromium.org>
        <20190411220822.81845-2-rrangel@chromium.org>
        <20190411183934.28e6ad65@gandalf.local.home>
        <20190412153036.GB101407@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412153036.GB101407@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 12 Apr 2019 09:30:36 -0600
Raul Rangel <rrangel@chromium.org> wrote:

> Ah, I wasn't aware that the format was exposed via sysfs. That makes
> sense why the macros are used. I was using xhci-trace as my reference
> point which just calls arbitrary functions.
> 
> cat /sys/kernel/debug/tracing/events/xhci-hcd/xhci_handle_event/format
> print fmt: "%s: %s",
> xhci_ring_type_string(REC->type),
> xhci_decode_trb(REC->field0, REC->field1, REC->field2, REC->field3)
> 
> I'm guessing calling out to a function is not the way the framework was
> intended to be used. Does this mean that every TRB type in xhci_decode_trb
> should be its own trace event so the printf format isn't hidden inside
> the code?

You can add plugins to handle this. See tools/lib/traceevent/plugin_*.c

> 
> > 
> > How does perf or trace-cmd parse this? To add something like this, you
> > need them to have the same output as what is displayed by the trace
> > file otherwise NAK.  
> 
> So for the short term I can remove __print_register. The SDHCI tracing
> doesn't use it, but instead calls out to a method that calls
> trace_print_register directly. Or I could move trace_print_register
> into the sdhci-trace module.

For the short term yeah. And you can add a plugin to the libtraceevent
to teach trace-cmd and perf how to parse it.
See "tep_register_print_function()"

> 
> cat /sys/kernel/debug/tracing/events/sdhci/sdhci_read/format
> 
> print fmt: "%s: %#x [%s] => %#x: %s",
>   __get_str(name),
>   REC->reg,
>   __print_symbolic(REC->reg & ~3UL, {0x00, "DMA_ADDRESS"}, ...),
>   REC->val,
>   sdhci_decode_register( p, REC->reg, REC->val, REC->mask )
> 
> The format prints out the raw value, so using perf or trace-cmd
> will still have value, you just won't get the pretty print.
> 
> For the long term I could make event-parser handle __print_register. I'm
> assuming it just needs to handle the additional case?
> https://github.com/torvalds/linux/blob/master/tools/lib/traceevent/event-parse.c#L3040
> 

Yes, I'm fine with adding new generic functions that can parse the code
properly to libtraceevent. Anything added to the trace_event code
should have a corresponding routine added to libtraceevent. Just
remember, that those *are* user API, and once made, they can not change.

Thanks!

-- Steve
