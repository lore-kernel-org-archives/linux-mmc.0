From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for hardware reset of eMMC card on
 reboot
Date: Thu, 05 Feb 2015 00:39:16 +0900
Message-ID: <54D23D24.7050808@kernel.org>
References: <1422866028-27891-1-git-send-email-m.szyprowski@samsung.com> <CABxcv=m2UjyF3V_B0PZkfA_jFkUPpKL+ZAmgBxTzmUb7JSwLiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CABxcv=m2UjyF3V_B0PZkfA_jFkUPpKL+ZAmgBxTzmUb7JSwLiQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 02/02/15 17:51, Javier Martinez Canillas wrote:
> Hello Marek,
> 
Hi Marek,

> On Mon, Feb 2, 2015 at 9:33 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hello,
>>
>> This patchset adds new mmc power sequence driver, which performs eMMC
>> card hardware reset. Such power sequence, involving resetting emmc card,
>> is required on some boards to properly perform system reboot procedure.
>>
> 
> Patches looks good to me, I've only one comment on patch 1/3. Once
> that is addressed, feel free to add for all the series:
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
Applied 2/3 and 3/3 DT updates.

Thanks,
Kukjin
