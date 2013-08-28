From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [RFC V2 0/4] dw_mmc platform specific private data init
Date: Wed, 28 Aug 2013 11:16:19 +0530
Message-ID: <CAGOxZ510xNnRPobEQuwTEfs-xxJdwtkvDVzjm_tU6oMT3ux2SQ@mail.gmail.com>
References: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Girish K S <ks.giri@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Yuvaraj

On Fri, Aug 23, 2013 at 4:45 PM, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
> changes from V1:
>         1.Added a new RFC patch
>                 mmc: dw_mmc: socfpga: move socfpga private init
>         2.Avoid code duplication in
>                 mmc: dw_mmc: exynos: add a quirk for SMU.
>
> Yuvaraj Kumar C D (4):
>   mmc: dw_mmc: exynos: move the exynos private init
>   mmc: dw_mmc: socfpga: move socfpga private init
>   mmc: dw_mmc: move the platform specific init call
>   mmc: dw_mmc: exynos: add a quirk for SMU.
>
>  drivers/mmc/host/dw_mmc-exynos.c  |   60 ++++++++++++++++++++++++++++---------
>  drivers/mmc/host/dw_mmc-pltfm.c   |    7 -----
>  drivers/mmc/host/dw_mmc-socfpga.c |   29 +++++++++---------
>  drivers/mmc/host/dw_mmc.c         |   12 ++++++++
>  include/linux/mmc/dw_mmc.h        |    2 ++
>  5 files changed, 74 insertions(+), 36 deletions(-)

Tested this serise on exynos5420.
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
