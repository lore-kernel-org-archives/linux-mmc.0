From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 2/4] mmc: core: Add trace event for SD SSR response
Date: Mon, 15 Apr 2019 19:34:10 -0400
Message-ID: <20190415193410.2b33d1d6@gandalf.local.home>
References: <20190415225241.70088-1-rrangel@chromium.org>
        <20190415225241.70088-2-rrangel@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415225241.70088-2-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, hongjiefang <hongjiefang@asrmicro.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 15 Apr 2019 16:52:39 -0600
Raul E Rangel <rrangel@chromium.org> wrote:

> Example:
> sd_ssr: mmc0: au: 8192, erase time: 0, erase offset: 0x0, raw: {0x0,0x3000000,0x1019000,0x10000,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/core/sd.c      |  2 ++
>  include/trace/events/mmc.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 3bed7c4b6d75..cc33a4f96c6a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -282,6 +282,8 @@ static int mmc_read_ssr(struct mmc_card *card)
>  		}
>  	}
>  
> +	trace_sd_ssr(card);
> +
>  	/*
>  	 * starting SD5.1 discard is supported if DISCARD_SUPPORT (b313) is set
>  	 */
> diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
> index e45258e8a6cb..cad604ee800f 100644
> --- a/include/trace/events/mmc.h
> +++ b/include/trace/events/mmc.h
> @@ -52,6 +52,37 @@ TRACE_EVENT(sd_scr,
>  	)
>  );
>  
> +TRACE_EVENT(sd_ssr,
> +
> +	TP_PROTO(struct mmc_card *card),
> +
> +	TP_ARGS(card),
> +
> +	TP_STRUCT__entry(
> +		__array(u32,			raw,	16)
> +		__field(unsigned int,		au)
> +		__field(unsigned int,		erase_timeout)
> +		__field(unsigned int,		erase_offset)
> +		__string(name,			mmc_hostname(card->host))
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->raw, card->raw_ssr, sizeof(card->raw_ssr));

Again, memcpy() with the size of the source is dangerous.

Hmm, I wonder if a BUILD_BUG_ON(sizeof(u32)*16 < sizeof(card->raw_ssr))
would work here too. If it does, then that would be another approach.

-- Steve

> +		__entry->au = card->ssr.au;
> +		__entry->erase_timeout = card->ssr.erase_timeout;
> +		__entry->erase_offset = card->ssr.erase_offset;
> +		__assign_str(name, mmc_hostname(card->host));
> +	),
> +
> +	TP_printk("%s: au: %d, erase time: %d, erase offset: %#x, raw: %s",
> +		  __get_str(name),
> +		  __entry->au,
> +		  __entry->erase_timeout,
> +		  __entry->erase_offset,
> +		  __print_array(__entry->raw, 16, sizeof(u32))
> +	)
> +);
> +
>  TRACE_EVENT(mmc_request_start,
>  
>  	TP_PROTO(struct mmc_host *host, struct mmc_request *mrq),
