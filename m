From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 0/5] consolidate sdhci pltfm & OF drivers and get them
 self registered
Date: Tue, 19 Apr 2011 21:47:22 +0900
Message-ID: <BANLkTinfhb3vejJSM4y-C=3vk5RE76gPjQ@mail.gmail.com>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<20110419102031.GA4164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110419102031.GA4164@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org, sameo@linux.intel.com, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

BTW, Are there reason to omit the sdhci-s3c.c? Maybe Mr. Jung will hand=
le it.

Thank you,
Kyungmin Park

On Tue, Apr 19, 2011 at 7:20 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
> Hi Shawn,
>
> On Fri, Mar 25, 2011 at 04:48:46PM +0800, Shawn Guo wrote:
>> Here are what the patch set does.
>>
>> * Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
>> =A0 a pure common helper function providers.
>> * Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx=
,
>> =A0 sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
>> =A0 registered with calling helper functions created above.
>> * Migrate the use of sdhci_of_host and sdhci_of_data to
>> =A0 sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host a=
nd
>> =A0 data structure works can be saved, and pltfm version works for b=
oth
>> =A0 cases.
>> * Add OF common helper stuff into sdhci-pltfm.c, and make OF version
>> =A0 sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
>> =A0 registered as well, so that sdhci-of-core.c and sdhci-of.h can b=
e
>> =A0 removed.
>> * Consolidate the OF and pltfm esdhc drivers into one with sharing
>> =A0 the same pair of .probe and .remove hooks. =A0As a result,
>> =A0 sdhci-esdhc-imx.c and sdhci-of-esdhc.c go away, while
>> =A0 sdhci-esdhc.c comes in and works for both MPCxxx and i.MX.
>> * Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
>> =A0 drivers/mmc/host/sdhci-pltfm.h.
>>
>> And the benefits we gain from the changes are:
>>
>> * Get the sdhci device driver follow the Linux trend that driver
>> =A0 makes the registration by its own.
>> * sdhci-pltfm.c becomes simple and clean as it only has common helpe=
r
>> =A0 stuff there now.
>> * All sdhci device specific things are going back its own driver.
>> * The dt and non-dt drivers are consolidated to use the same pair of
>> =A0 .probe and .remove hooks.
>> * SDHCI driver for Freescale eSDHC controller found on both MPCxxx
>> =A0 and i.MX platforms is consolidated to use the same one .probe
>> =A0 function.
>>
>> The patch set works against the tree below, and was only tested on
>> i.mx51 babbage board, all other targets were build tested.
>>
>> =A0 git://git.secretlab.ca/git/linux-2.6.git devicetree/test
>>
>> Comments are welcomed and appreciated.
>
> First of all, thanks _a lot_ for doing this! Many people have promise=
d
> to do such an approach, but you finally made it!
>
> Sorry for the long delay in reviewing it, I didn't want to rush a rev=
iew
> so I needed some time for it which I didn't have much in the last wee=
ks.
> Let's hope my battery will have enough power on my flight back to
> Germany ;) So, this is for now a purely "visual" review. I hope I can
> check V2 on real hardware then.
>
> The approach seems sensible, so have a look at my (mostly minor)
> comments inside the patches. However, there is one bigger piece missi=
ng.
> You converted all the drivers which had a seperate source-file and
> hooked into sdhci-pltfm.c. However, those are only those users which
> need additional code to work around the quirks. There are also users
> which can take the plain pltfm-driver with a properly set
> platform_data (check the thread "[PATCH] mmc: add SDHCI driver for ST=
M
> platforms (V2)" for an example). Those have to be converted, too.
> Now the discussion could be if every of those users gets its own
> pltfm-<something>.c or if we create something similat to
> sdhci-pltfm-generic, which can also be setup with platform_data like =
the
> old driver (/me likes the latter a bit more. If we don't change the n=
ame
> of the driver (not talking about the sourcefile) and keep it
> "sdhci-pltfm", then you wouldn't need to change all those users if yo=
u
> ensured it behaves the same.
>
> Also, I think the next version of this series should have all makers =
of
> a sdhci-pltfm user CCed so we give them a chance to report breakage. =
Or
> donate acks or tested-by.
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk2tYe8ACgkQD27XaX1/VRsCRgCgkp+BmJJsLsKllKL0OI/BnO9F
> PRkAn1BpnXBv1exnkJFlqFAPe5O2Yt8w
> =3DGSqA
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
>
