From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Wed, 19 Oct 2011 10:50:37 +0900
Message-ID: <4E9E2CED.2060305@samsung.com>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
 <4E9D0B9F.1060303@samsung.com> <m2ehya6ecb.fsf@bob.laptop.org>
 <CAGxe1ZHvRS9hek9-DSXZm1fkqPzUSVkWF5yEGXTC4K8usA31WQ@mail.gmail.com>
 <m239eq5ulj.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <m239eq5ulj.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris.

Thank you for merged about eMMC4.5 feature.

Best regards,
Jaehoon Chung

On 10/18/2011 09:53 PM, Chris Ball wrote:

> Hi,
> 
> On Tue, Oct 18 2011, Girish K S wrote:
>>>  missing one thing.    unsigned int        power_notify_type; in include/linux/mmc/host.h
>> is not alligned to the above member, which was done in my latest patch
> 
> Fixed.  Thanks!
> 
> - Chris.
