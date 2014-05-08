From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mmc: rtsx: Revert "mmc: rtsx: add support for
 pre_req and post_req"
Date: Thu, 8 May 2014 08:53:57 +0100
Message-ID: <20140508075357.GB5307@lee--X1>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <6a8f18cad47244e849adf8a731c621932fa777e0.1398735435.git.micky_ching@realsil.com.cn>
 <CAPDyKFqSdvjJrsbDeX1KbjQtOjfoAwC0xz3y7Rm-BsD0T8tmxg@mail.gmail.com>
 <CAPDyKFoEWkzHDfPn3BXVuXFMcfsLFtZdvsV36a7ic0DjCgu+NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoEWkzHDfPn3BXVuXFMcfsLFtZdvsV36a7ic0DjCgu+NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, micky <micky_ching@realsil.com.cn>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>
List-Id: linux-mmc@vger.kernel.org

> >> This reverts commit c42deffd5b53c9e583d83c7964854ede2f12410d.
> >>
> >> commit <mmc: rtsx: add support for pre_req and post_req> did use
> >> mutex_unlock() in tasklet, but mutex_unlock() can't used in
> >> tasklet(atomic context). The driver need use mutex to avoid concur=
rency,
> >> so we can't use tasklet here, the patch need to be removed.
> >>
> >> The spinlock host->lock and pcr->lock may deadlock, one way to sol=
ve the
> >> deadlock is remove host->lock in sd_isr_done_transfer(), but if us=
ing
> >> workqueue the we can avoid using the spinlock and also avoid the p=
roblem.
> >>
> >> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Hi Lee,
>=20
> Would you mind to pick this up and send it for 3.15 fixes?
>=20
> The other revert "[PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify
> error handle and remove smatch warnings", needs to go through the mmc
> tree.

Sent.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
