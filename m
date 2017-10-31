From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: mmc: vub300: Use common code in __download_offload_pseudocode()
Date: Tue, 31 Oct 2017 10:15:38 +0100
Message-ID: <b809399c-6bd0-5a39-d2b9-442f7d008e72@users.sourceforge.net>
References: <7b418db1-ec35-4c85-5d06-45edde56822c@users.sourceforge.net>
 <CAPDyKFp6h_DAcDvDEMft_WApEakdPQiMw0v8t2fPVxS+H1KkOA@mail.gmail.com>
 <20171030121508.zfnsvpsrt25prhr4@mwanda>
 <CAPDyKFqaaX3i5wLu-aORRB765Kjac705384UM4nCbV8n1Kfc3w@mail.gmail.com>
 <20171031084552.mvvn73pfew4rebsd@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171031084552.mvvn73pfew4rebsd@mwanda>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

>>> What's the advantage of this patch?  The new code seems more complicated
>>> to me and GCC automatically reuses duplicate constant strings so there
>>> is no memory savings.
>>
>> It looked to me that the error path got a bit cleaner. However, I
>> guess it's matter of taste.
>>
>> If you insist, I can drop it.
> 
> I'm on the kernel-janitors list so I am CC'd on all of Markus's patches.

Do you want that I omit this address from the list of recipients?


> It's not my code and I'm tired of being the anti-Markus guy

Interesting …

But I got the impression that this special relationship resulted
also in a few useful side effects.


> so this patch is fine.

Thanks for another bit of acceptance.


> Markus has a tool that finds duplicate strings and he uses gotos
> to avoid them.

Yes. - The script which I am using for the semantic patch language
(Coccinelle software) can not only find this implementation detail
but also duplicate source code generally to some degree.


> I don't think duplicate strings are a problem

They can become an issue for further considerations if inappropriate
error messages were used for example.

There are more statement combinations which can be improved a bit more.


> or that it's a good idea to send over a hundred patches using this method.

The change acceptance is varying as usual.


> But many people have explained that to Markus already

I hope that my contributions can improve the affected software in some areas.


> and that's not the bigger picture which is about error handling and labels.
> What I like are labels that are necessary and self explanatory.

It seems that this is a topic where you got strong opinions about.


> You're reading along and you're like "what happens at the err" label?

Would you accept any further adjustments around questionable jump targets?

Regards,
Markus
