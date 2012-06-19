From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Tue, 19 Jun 2012 15:53:30 +0900
Message-ID: <CANqRtoQD+sneTT7tCYji7YGpX5eJEQrWCQoX8jWJ1hiChjFh_g@mail.gmail.com>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
	<1538938.WjgJgiBpYR@avalon>
	<CANqRtoS3JqNHFXcOutssQxpD6DNnyV1QawT2hf251z5d05LJWw@mail.gmail.com>
	<Pine.LNX.4.64.1206150907110.11729@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1206150907110.11729@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 15, 2012 at 4:09 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 15 Jun 2012, Magnus Damm wrote:
>
> [snip]
>
>> Guennadi, does this trigger on sh7372 as well? If not, why is that?
>
> No. That message is produced by the sh_mobile_sdhi_wait_idle() function,
> which is only used, if the TMIO_MMC_HAS_IDLE_WAIT flag is set, which is
> not set on mackerel (or ap4evb).

Ok, thanks for checking this. It seems that we are "lucky" to find
this breakage...

In the future, please take care to make sure this does not happen
again. This goes without saying, but the driver should not access the
hardware when it is Runtime PM suspended. I believe it should be
possible to verify the code paths by manual code inspection. Also, to
make the behavior more consistent you may want to make use of
"pm_runtime_put_sync()" instead of "pm_runtime_put()".

Thanks,

/ magnus
