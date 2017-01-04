From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix some coding style
Date: Wed, 4 Jan 2017 15:03:34 +0200
Message-ID: <CAHp75VdKUAA-BcXn-=xJ63V6DewSUfy=c3cvK2qOPTbz0EzEDA@mail.gmail.com>
References: <1483534376-6521-1-git-send-email-xzy.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483534376-6521-1-git-send-email-xzy.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ziyuan Xu <xzy.xu@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 4, 2017 at 2:52 PM, Ziyuan Xu <xzy.xu@rock-chips.com> wrote:
> Let's fix the warnings from checkpatch.pl:
>
> - line over 80 characters;
> - block comments should align the * on each Lines;
> - statements not starting on a tabstop.

>         __le32          des1;   /* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
> -       ((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | (cpu_to_le32((s) & 0x1fff)))
> +       ((d)->des1 = ((d)->des1 & cpu_to_le32(0x03ffe000)) | \
> +        (cpu_to_le32((s) & 0x1fff)))

I don't think there is a significant value to split. How many
characters it fits right now?
Up to 90 for such a code is okay for my point of view. It makes it
more readable than split variant.

-- 
With Best Regards,
Andy Shevchenko
