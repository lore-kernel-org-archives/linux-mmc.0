From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/7] mmc: sdhci-pltfm: bail out if register resource is
 too small
Date: Tue, 19 Apr 2016 16:28:11 +0300
Message-ID: <5716326B.2040403@intel.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
 <1460600990-10993-2-git-send-email-yamada.masahiro@socionext.com>
 <57161754.5050303@intel.com>
 <CAK7LNAScX-JP13w4zZ3Fb=9HQQeqtzN0iyxocGBkLbeZyHxcPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAScX-JP13w4zZ3Fb=9HQQeqtzN0iyxocGBkLbeZyHxcPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 19/04/16 14:46, Masahiro Yamada wrote:
> Hi Adrian,
> 
> 
> 2016-04-19 20:32 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:
>> On 14/04/16 05:29, Masahiro Yamada wrote:
>>> This code checks the resource size and displays an error message if
>>> it is too small, but still moves forward.  Let is fail in that case.
>>
>> is -> it
>>
>> How do you know there aren't drivers that actually have a smaller size?
> 
> No, I do not know.
> 
> This is an error message, so I think it should fail in that case.
> 
> 
> Maybe, can we drop this check completely?

Yes, I think so.
