From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue, 3 Apr 2012 17:06:35 +0900
Message-ID: <CAKYAXd_9AwrBpbVoZxPN6JNcg1SQP6pemJ4gAY4gZQKRQexqmg@mail.gmail.com>
References: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
	<CAGxe1ZHZ2jvZzAzRch9-yMS2pXqo0C2VaFgSv4-ENTFbUhA=2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZHZ2jvZzAzRch9-yMS2pXqo0C2VaFgSv4-ENTFbUhA=2w@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2012/4/3 Girish K S <girish.shivananjappa@linaro.org>:
> On 3 April 2012 15:55, Subhash Jadavani <subhashj@codeaurora.org> wro=
te:
>> mmc_select_powerclass() function returns error if eMMC
>> VDD level supported by host is between 2.7v to 3.2v.
>>
>> According to eMMC specification, valid voltage for high
>> voltage cards is 2.7v to 3.6v. This patch ensures that
>> 2.7v to 3.6v VDD range is treated as valid range.
>>
>> Also, failure to set the power class shouldn't be treated
>> as fatal error because even if setting the power class
>> fails, card can still work in default power class.
>> If mmc_select_powerclass() returns error, just print
>> the warning message and go ahead with rest of the card
>> initialization.
>>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> looks good to me
> Acked By: =C2=A0Girish K S <girish.shivananjappa@linaro.org>

I double checked with specification. this patch make good sense.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks

>> --
>> 1.7.1.1
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
=46orum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
