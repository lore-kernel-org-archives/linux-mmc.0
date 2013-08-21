From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v5 0/4] mmc: dw_mmc: fixes for suspend/resume on exynos
Date: Wed, 21 Aug 2013 20:48:27 +0900
Message-ID: <001e01ce9e64$59c3b780$0d4b2680$%jun@samsung.com>
References: <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1376066000-5495-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1376066000-5495-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Olof Johansson' <olof@lixom.net>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Doug,
Do you have any update for this series?
Please let me know.

Thanks,
Seungwon Jeon

On Sat, August 10, 2013, Doug Anderson wrote:
> This series of patches addresses some suspend/resume problems with
> dw_mmc on exynos platforms, espeically exynos5420.  Since
> suspend/resume is not fully working on ToT Linux (v3.11-rc4) on
> exynos5250-snow, this series was tested against the current ToT
> ChromeOS 3.8 tree.  I have confirmed basic booting and eMMC / SD card
> usage (and compiling, honest!) against ToT Linux.
> 
> I have received confirmation from Samsung that the problem solved is a
> silicon errata on exynos5420 and that this is a good fix.
> 
> Changes in v5:
> - Remove force_clkinit as per Jaehoon.
> - Update commit message to (hopefully) be clearer.
> - Cleaned up dw_mci_exynos_resume_noirq() comment as per Seungwon.
> - Don't memcpy dev_pm_ops structure, define a new one.
> 
> Changes in v4:
> - Take Seungwon's suggestion and don't add any dw_mmc-pltfm code.
> 
> Changes in v3:
> - Add freeze/thaw and poweroff/restore noirq entries.
> 
> Changes in v2:
> - Fix typo (some -> come)
> - Use ~0 instead of 0xFFFFFFFF; add comment about value
> - Use suspend_noirq as per James Hogan.
> 
> Doug Anderson (4):
>   mmc: dw_mmc: Invalidate cache of current_speed after suspend/resume
>   mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
>   mmc: dw_mmc: Always setup the bus after suspend/resume
>   mmc: dw_mmc: Set timeout to max upon resume
> 
>  drivers/mmc/host/dw_mmc-exynos.c | 56 +++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.c        | 21 ++++++++++-----
>  2 files changed, 69 insertions(+), 8 deletions(-)
> 
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
