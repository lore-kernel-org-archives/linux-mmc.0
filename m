From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/8] trivial: coding style fixes
Date: Fri, 16 Oct 2009 16:46:01 +0200
Message-ID: <4AD88729.3050209@s5r6.in-berlin.de>
References: <1255635840-5691-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932582AbZJPOsK@vger.kernel.org>
In-Reply-To: <1255635840-5691-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: trivial@kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-mmc@vger.kernel.org

Thadeu Lima de Souza Cascardo wrote:
> --- a/drivers/mmc/card/sdio_uart.c
> +++ b/drivers/mmc/card/sdio_uart.c
[...]
> @@ -946,31 +948,31 @@ static int sdio_uart_proc_show(struct seq_file *m, void *v)
>  			seq_printf(m, "%d: uart:SDIO", i);
>  			if(capable(CAP_SYS_ADMIN)) {
>  				seq_printf(m, " tx:%d rx:%d",
> -					       port->icount.tx, port->icount.rx);
> +					      port->icount.tx, port->icount.rx);
>  				if (port->icount.frame)
>  					seq_printf(m, " fe:%d",
> -						       port->icount.frame);
> +						      port->icount.frame);
>  				if (port->icount.parity)
>  					seq_printf(m, " pe:%d",
> -						       port->icount.parity);
> +						      port->icount.parity);
>  				if (port->icount.brk)
>  					seq_printf(m, " brk:%d",
> -						       port->icount.brk);
> +						      port->icount.brk);
>  				if (port->icount.overrun)
>  					seq_printf(m, " oe:%d",
> -						       port->icount.overrun);
> +						      port->icount.overrun);
>  				if (port->icount.cts)
[...]

The style problem of the original code was not indentation, but depth of
indentation levels.  Why not factor this cascade out to a
show_icount_fields() function?

Plus, I hope Jiri enhanced your changelog a bit before he committed it.
(I only looked at this patch because I was wondering what subsystem it
changed --- the patch title doesn't say it.)
-- 
Stefan Richter
-=====-==--= =-=- =----
http://arcgraph.de/sr/
