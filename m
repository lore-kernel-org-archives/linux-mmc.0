From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: Re: MMC regression with linux-next on Exynos5250
Date: Wed, 18 Jun 2014 16:40:19 +0530
Message-ID: <CAK5sBcHwteYZBf4S=m8WvL68_qkPqO=BVC6yWMfK3x17a9p5-A@mail.gmail.com>
References: <CAK5sBcEVEWwyHLj_y1=eTqWNELuahMUwrtyX2W_YzLe70Dsa4A@mail.gmail.com>
	<53A167DB.2000701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53A167DB.2000701@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

On Wed, Jun 18, 2014 at 3:50 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Sachin.
>
> Did you check the below patch?
> https://patchwork.kernel.org/patch/4346781/

Thanks for the patch. But even with this patch, I continue to get the
aforementioned crash.

>
> I will resend the patch after including the ARM soc mailing.
>
> dw-mmc controller used the mmc_of_parse(), but it can't parse the sub-node.
> After checking it, let me know your result, plz.

Regards,
Sachin.
