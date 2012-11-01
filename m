From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] exynos: mmc: use correct variable for MODULE_DEVICE_TABLE
Date: Thu, 01 Nov 2012 19:07:36 +0900
Message-ID: <010401cdb818$b7912100$26b36300$%jun@samsung.com>
References: <1351635712-17214-1-git-send-email-slyich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1351635712-17214-1-git-send-email-slyich@gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Sergei Trofimovich' <slyich@gmail.com>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Sergei Trofimovich' <slyfox@gentoo.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Will Newton' <will.newton@imgtec.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, October 31, 2012, Sergei Trofimovich <slyfox@gentoo.org> wrote:
> From: Sergei Trofimovich <slyfox@gentoo.org>
> 
> Found by gcc:
> 
>     linux-2.6/drivers/mmc/host/dw_mmc-exynos.c: At top level:
>     linux-2.6/drivers/mmc/host/dw_mmc-exynos.c:226:1: error: '__mod_of_device_table' aliased to
> undefined symbol 'dw_mci_pltfm_match'
> 
> CC: Chris Ball <cjb@laptop.org>
> CC: Thomas Abraham <thomas.abraham@linaro.org>
> CC: Will Newton <will.newton@imgtec.com>
> CC: linux-mmc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

I suggest changing the prefix of subject.
'mmc: dw_mmc-exynos' instead of 'exynos: mmc'

Thanks,
Seungwon Jeon
