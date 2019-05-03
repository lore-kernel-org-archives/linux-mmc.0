From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Fri, 3 May 2019 08:55:23 -0500
Message-ID: <f95df8d1-07f9-1b89-a572-cf4b98e52c39@embeddedor.com>
References: <20190501203621.GA11352@embeddedor>
 <CAPDyKFr0KrUCuBpYyypKiUsin98XaYOVUx8MuDEpxvm6knxrzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr0KrUCuBpYyypKiUsin98XaYOVUx8MuDEpxvm6knxrzw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org



On 5/3/19 8:29 AM, Ulf Hansson wrote:
> On Wed, 1 May 2019 at 22:36, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>

[..]

>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied for next, thanks!
> 
> I took the liberty to clean up the comments, avoiding to break 80
> chars per line.
> 

Awesome. :)

Thanks, Uffe.
--
Gustavo
