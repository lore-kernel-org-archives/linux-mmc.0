From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device tree support
Date: Tue, 27 Mar 2012 11:50:24 -0400
Message-ID: <87k426vy9r.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
	<m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
	<m239abgc32.fsf@bob.laptop.org>
	<00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
	<m2vcn0496y.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2vcn0496y.fsf@bob.laptop.org> (Chris Ball's message of "Tue, 21
	Feb 2012 08:17:41 -0500")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Kukjin,

On Tue, Feb 21 2012, Chris Ball wrote:
> On Tue, Feb 21 2012, Kukjin Kim wrote:
>> I created topic branch for this we talked. You can pull that following:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> v3.4-for-cjb
>>
>> If any problems, please kindly let me know.
>
> Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
> to Linus.)

I was expecting you to merge these patches, but they aren't in the
arm-soc tree and haven't been sent to Linus, and we're in the last few
days of the merge window.

As a result I'm dropping this tree -- and all of the patches that I
have on top of it -- from mmc-next so that I can get a pull request
out.  This means that I'm dropping:

mmc: sdhci-s3c: Add device tree support
mmc: sdhci-s3c: Keep a copy of platform data and use it
mmc: sdhci-s3c: derive transfer width host capability from max_width in 
ARM: SAMSUNG: remove all uses of clk_type member in sdhci platform data
ARM: EXYNOS: use 'exynos4-sdhci' as device name for sdhci controllers
mmc: sdhci-s3c: Remove usage of clk_type member in platform data

.. which I was expecting you to merge, and also:

mmc: sdhci-s3c: fix broken compilation for non-Exynos SoCs
mmc: sdhci-s3c: Enable runtime power management
mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system suspend
mmc: sdhci-s3c: use devm_ functions

.. which were merged on top of the above patches.

We'll have to try again with 3.5 for the new features, and post-rc1 for
the fixes.  Please let me know what happened with this merge.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
