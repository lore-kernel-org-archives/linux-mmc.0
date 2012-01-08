From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V9 0/2] HS200 Mode support for device and host
Date: Sun, 8 Jan 2012 11:20:24 +0530
Message-ID: <CAGxe1ZEXi+WBh34EEX1jifF=3GnddodJGNhA2rLFxHWcmMRP0w@mail.gmail.com>
References: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1325823999-21770-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

HI Chris,
Please have a look at this patch series and add it in your next branch
if everything seems to be Ok

regards
Girish K S

On 6 January 2012 09:56, Girish K S <girish.shivananjappa@linaro.org> w=
rote:
> changes in v9:
> =A0 =A0 =A0 =A0Updated the changes suggested by Chris for kernel codi=
ng comaptibility
> changes in v8:
> =A0 =A0 =A0 =A0Updated the changes suggested by Philip for bus mode t=
est.
> changes in v7:
> =A0 =A0 =A0 =A0Updated with review comments for minor changes in host=
 conditional
> =A0 =A0 =A0 =A0handling. added the handling for 4 bit bus width.
> Changes in v6:
> =A0 =A0 =A0 =A0split the patch into 2 and classified them as a patch =
for device
> =A0 =A0 =A0 =A0and host. Modified to include the review comments.
> Changes in v5:
> =A0 =A0 =A0 =A0Reduced the case statements for better code readabilit=
y. Removed
> =A0 =A0 =A0 =A0unused macro definitions. Modified the tuning function=
 prototype
> =A0 =A0 =A0 =A0and definition to support tuning for both SD and eMMC =
cards.
> Changes in v4:
> =A0 =A0 =A0 =A0Rebased onto chris-mmc/mmc-next branch. This patch is =
successfully
> =A0 =A0 =A0 =A0applied on commit with id de022ed3fdc14808299b2fa66dbb=
1ed5ab921912.
> Changes in v3:
> =A0 =A0 =A0 =A0In the previous commits of chris-mmc/mmc-next branch, =
the patch with
> =A0 =A0 =A0 =A0commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) d=
efines caps2 for
> =A0 =A0 =A0 =A0more capabilities. This patch version deletes the memb=
er ext_caps
> =A0 =A0 =A0 =A0(created in my earlier patch) from struct mmc_host and=
 reuses already
> =A0 =A0 =A0 =A0accepted caps2 member.
> Changes in v2:
> =A0 =A0 =A0 =A0Rebased to latest chris-mmc/mmc-next branch. Resolved =
indentation
> =A0 =A0 =A0 =A0problems identified in review. This patch has to be ap=
plied before
> =A0 =A0 =A0 =A0the patch released for modifying the printk messages.
> Changes in v1:
> =A0 =A0 =A0 =A0Case statements in switch that produce same result hav=
e been combined
> =A0 =A0 =A0 =A0to reduce repeated assignments. patch recreated after =
rebase to chris
> =A0 =A0 =A0 =A0Balls mmc-next branch.
>
> Girish K S (2):
> =A0mmc: core: HS200 mode support for eMMC 4.5
> =A0mmc: host: Adds support for eMMC 4.5 HS200 mode
>
> =A0drivers/mmc/core/bus.c =A0 =A0 | =A0 =A03 +-
> =A0drivers/mmc/core/debugfs.c | =A0 =A03 +
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0162 ++++++++++++++++++++++++++=
+++++++++++++++---
> =A0drivers/mmc/core/sd.c =A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/mmc/core/sdio.c =A0 =A0| =A0 =A04 +-
> =A0drivers/mmc/host/sdhci.c =A0 | =A0 45 +++++++++---
> =A0drivers/mmc/host/sdhci.h =A0 | =A0 =A01 +
> =A0include/linux/mmc/card.h =A0 | =A0 =A03 +
> =A0include/linux/mmc/host.h =A0 | =A0 11 +++-
> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 66 ++++++++++++++++++-
> =A0include/linux/mmc/sdhci.h =A0| =A0 =A01 +
> =A011 files changed, 277 insertions(+), 25 deletions(-)
>
