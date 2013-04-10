From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: let device core setup the default pin configuration
Date: Wed, 10 Apr 2013 18:18:37 +0530
Message-ID: <CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Patch Tracking <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 10 April 2013 05:00, Doug Anderson <dianders@chromium.org> wrote:
> Thomas,
>
> On Mon, Apr 8, 2013 at 10:59 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> @@ -2002,7 +1994,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>                 if (ret) {
>>                         dev_err(host->dev,
>>                                 "failed to enable regulator: %d\n", ret);
>> -                       goto err_setup_bus;
>> +                       return ret;
>
> It seems like you'd need a "mmc_free_host(mmc);" in this case don't
> you?  AKA: this should be a goto and not a return.

Hi Doug,

The call to regulator_enable() is prior to the call to mmc_add_host().
Hence, call to mmc_fre_host is not required in this case. So the above
change should be right.

Thanks,
Thomas.

>
> -Doug
