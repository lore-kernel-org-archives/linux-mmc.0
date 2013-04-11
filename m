From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: let device core setup the default pin configuration
Date: Thu, 11 Apr 2013 17:36:32 +0530
Message-ID: <CAJuYYwQaO1dArYPAbr3mW3gJQjK4bSWGYvgT_t+aUsZTxDgnUg@mail.gmail.com>
References: <1365487186-4587-1-git-send-email-thomas.abraham@linaro.org>
	<CAD=FV=VJ-ykDNqYKQ=fqxeOD6bRNLW02VT4bjsRHRAuXLcCpQQ@mail.gmail.com>
	<CAJuYYwQT=povqiutVHXkF5jxTAnjpwTMQ5G0Z6xKGnnM7qYADQ@mail.gmail.com>
	<CAD=FV=UddWM=yc5N9=jwbMDpZ7Bpg7o3Z714CnBSg=iHhmPxWw@mail.gmail.com>
	<CAD=FV=WyPbkYvq9udPzQtVnaXZR3jzXTPnBrrdxpUuX3CZT=Og@mail.gmail.com>
	<001101ce3662$7ecb9850$7c62c8f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001101ce3662$7ecb9850$7c62c8f0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Girish Shivananjappa <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, arm-linux <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Patch Tracking <patches@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 11 April 2013 08:43, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Wednesday, April 10, 2013, Doug Anderson wrote:
>> Thomas,
>>
>> On Wed, Apr 10, 2013 at 6:56 AM, Doug Anderson <dianders@chromium.org> wrote:
>> > On Wed, Apr 10, 2013 at 5:48 AM, Thomas Abraham
>> > <thomas.abraham@linaro.org> wrote:
>> >> The call to regulator_enable() is prior to the call to mmc_add_host().
>> >> Hence, call to mmc_fre_host is not required in this case. So the above
>> >> change should be right.
>> >
>> > Are you sure that mmc_free_host() is the opposite of mmc_add_host()
>> > and not mmc_alloc_host()?
>> >
>> > I'll double-check myself in a few hours when I'm in front of a computer.
>>
>> OK, I double checked and I'm still convinced that the free is needed
>> because we've already called mmc_alloc_host().  Current code always
>> makes sure to free when it returns an error and that seems right to
>> me.
> mmc_alloc_host corresponds to mmc_free_host. And mmc_add_host matches
> with mmc_remove_host. Let's focus on mmc_alloc_host.
> mmc_alloc_host is called prior to regulator_enable.
> So, if regulator_enable is failed, call of mmc_free_host makes sense.
>

Hi Doug, Seungwon,

Ok, I got it wrong again. Thanks for letting me know. I will fix this
and send the v5 of this patch.

Thanks,
Thomas.


> Thanks,
> Seungwon Jeon
>>
>> -Doug
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
