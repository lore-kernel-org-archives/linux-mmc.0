From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH RESEND v5] mmc: core: Remove bounce buffer in mmc_send_cxd_data()
Date: Thu, 2 Aug 2012 20:18:54 +0530
Message-ID: <CANfBPZ_pVuDU+cd_pQr+GxWd2Dsf3zjfnwW547Sm8SkDaJUuFA@mail.gmail.com>
References: <1343891231-3042-1-git-send-email-kyungsik.lee@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343891231-3042-1-git-send-email-kyungsik.lee@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungsik Lee <kyungsik.lee@lge.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, raphael.andy.lee@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 2, 2012 at 12:37 PM, Kyungsik Lee <kyungsik.lee@lge.com> wrote:
> It is expected that Extended CSD register(the size of this register
> is larger than CID/CSD) will be referenced more frequently as more
> fields have been added to Extended CSD and it seems that it is not
> a good option to double the memory used.
>
> This patch is intended to avoid the use of bounce buffer for reading
> Extended CSD register in mmc_send_cxd_data(). It will provide a better
> performance gain by removing memcpy() overhead for a half KiB and
> a redundant bounce buffer allocated repeatedly at the cost of providing
> DMA-capable buffer from upper caller(but on-stack buffer is allowed
> with no performance gain).
>
> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
> Signed-off-by: S, Venkatraman <svenkatr@ti.com>

I don't think my sign off is warranted. I gave just an illustration.
You can add my
Reviewed-by: Venkatraman S <svenkatr@ti.com>

Regards,
Venkat.
