From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: tmio/SDHI fixup patches
Date: Wed, 11 Dec 2013 20:45:35 -0500
Message-ID: <87txee6dvk.fsf@octavius.laptop.org>
References: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com> (Kuninori
	Morimoto's message of "Wed, 20 Nov 2013 00:30:03 -0800 (PST)")
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Kuninori,

On Wed, Nov 20 2013, Kuninori Morimoto wrote:
> Hi Chris
>
> Now, our new board would like to use sh_mobile_sdhi driver,
> then, it is expecting sh_mobile_sdhi use regulator.
> But, this regulator is based on GPIO driver,
> and GPIO driver probe timing is after sh_mobile_sdhi.
> So, sh_mobile_sdhi (= tmio_mmc_pio) use default ocr_avail,
> and it doesn't work for us.
> #1 patch returns -EPROBE_DEFER in such case.
> it changes tmio_mmc_host_probe() behavior, but
> in my check, tmio_mmc_pio driver user is sh_mobile_sdhi/tmio-mmc only,
> and, current user has no conflict by this patch.
>
> sh_mobile_sdhi/tmio-mmc is very similar, but, have some difference.
> #2 - #4 cares such case.
>
> These were part of "SDHI support for r8a7790" patch set,
> but was separated

Sorry for the delay, I've pushed all four patches to mmc-next for
3.14.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
