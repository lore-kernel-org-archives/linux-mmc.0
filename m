From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue, 03 Apr 2012 07:32:14 -0400
Message-ID: <87fwclhwzl.fsf@laptop.org>
References: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
	<CAGxe1ZHZ2jvZzAzRch9-yMS2pXqo0C2VaFgSv4-ENTFbUhA=2w@mail.gmail.com>
	<CAKYAXd_9AwrBpbVoZxPN6JNcg1SQP6pemJ4gAY4gZQKRQexqmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKYAXd_9AwrBpbVoZxPN6JNcg1SQP6pemJ4gAY4gZQKRQexqmg@mail.gmail.com>
	(Namjae Jeon's message of "Tue, 3 Apr 2012 17:06:35 +0900")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 03 2012, Namjae Jeon wrote:
> 2012/4/3 Girish K S <girish.shivananjappa@linaro.org>:
>> On 3 April 2012 15:55, Subhash Jadavani <subhashj@codeaurora.org> wr=
ote:
>>> mmc_select_powerclass() function returns error if eMMC
>>> VDD level supported by host is between 2.7v to 3.2v.
>>>
>>> According to eMMC specification, valid voltage for high
>>> voltage cards is 2.7v to 3.6v. This patch ensures that
>>> 2.7v to 3.6v VDD range is treated as valid range.
>>>
>>> Also, failure to set the power class shouldn't be treated
>>> as fatal error because even if setting the power class
>>> fails, card can still work in default power class.
>>> If mmc_select_powerclass() returns error, just print
>>> the warning message and go ahead with rest of the card
>>> initialization.
>>>
>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> looks good to me
>> Acked By: =C2=A0Girish K S <girish.shivananjappa@linaro.org>
>
> I double checked with specification. this patch make good sense.
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
