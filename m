From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd:mmc:rtsx: Change default tx phase
Date: Wed, 21 Aug 2013 09:48:42 +0100
Message-ID: <20130821084842.GE29850@lee--X1>
References: <cover.1377049122.git.wei_wang@realsil.com.cn>
 <0dd50ed0bb16afbb47d8de8ba6eb4f9d1c901d45.1377049122.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0dd50ed0bb16afbb47d8de8ba6eb4f9d1c901d45.1377049122.git.wei_wang@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, rogerable@realtek.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Aug 2013, wei_wang@realsil.com.cn wrote:

> From: Wei WANG <wei_wang@realsil.com.cn>
>=20
> The default phase can meet most cards' requirement, but it is not the
> optimal one. In some extreme situation, the rx phase point produced b=
y
> the following tuning process will drift quite a distance.
> Before tuning UHS card, this patch will set a more proper initial tx
> phase point, which is calculated from statistic data, and can achieve
> a much better tx signal quality.
>=20
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
> ---
>  drivers/mfd/rtl8411.c             |    4 +++
>  drivers/mfd/rts5209.c             |    2 ++
>  drivers/mfd/rts5227.c             |    2 ++
>  drivers/mfd/rts5229.c             |    2 ++
>  drivers/mfd/rts5249.c             |    2 ++
>  drivers/mmc/host/rtsx_pci_sdmmc.c |   58 +++++++++++++++++++++++++++=
----------
>  include/linux/mfd/rtsx_pci.h      |   15 ++++++++++
>  7 files changed, 69 insertions(+), 16 deletions(-)

MFD parts looks okay to me:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
