From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Thu, 5 Jan 2012 22:13:32 +0530
Message-ID: <CAJuYYwRiubBo5Y4K_x_VPeRWOzmHgegyV4Sh=Eee6JgfAmP2iA@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
	<1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
	<20111107211726.GC28491@ponder.secretlab.ca>
	<CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
	<4F047235.2090503@samsung.com>
	<CAJuYYwTMpde-528t=vQnbkJv_gG7xuOr05b1K-+H-RxYRX0iEQ@mail.gmail.com>
	<4F05CE60.5090402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F05CE60.5090402@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: kgene.kim@samsung.com, Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Hi Sylwester,

On 5 January 2012 21:52, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
[...]

>> Sorry for the delaying in completing this patchset. I will redo this
>> patchset and submit it soon. But 3.3-rc1 looks unlikely.
>
> Ok, thanks. It's fine, there is no rush. I was just curious because we have
> reused this sdhci driver update series and it seemed essential for initial
> DT support on Exynos4 machines. Just FYI I have prepared initial DT support
> patches for the S5P MIPI-CSI2 (s5p-mipi-csis) receiver driver.
> But the whole camera subsystem needs more work, i.e. resource dependencies
> (clock) between all involved devices (like image sensors and video capture
> platform devices) need to be resolved and method of registering sub-devices
> in the V4L2 core will likely need to be changed.

Thanks for the information. It was helpful to know that you are working on this.

Regards,
Thomas.

>
>
> --
> Thanks,
> Sylwester
