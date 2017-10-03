From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Tue, 3 Oct 2017 09:27:30 +0300
Message-ID: <184b3552-851c-7015-dd80-76f6eebc33cc@intel.com>
References: <20170905194739.GA31241@amd> <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
 <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <72c93a69-610f-027e-c028-379b97b6f388@intel.com> <20171002084131.GA24414@amd>
 <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
 <20171002130353.GA25433@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdJCGeQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Oct 2017 02:34:16 -0400
In-Reply-To: <20171002130353.GA25433@amd>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org

On 02/10/17 16:03, Pavel Machek wrote:
> On Mon 2017-10-02 14:06:03, Linus Walleij wrote:
>> On Mon, Oct 2, 2017 at 10:41 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>>>> Bounce buffers are being removed from v4.15
>>
>> As Adrian states, this would make any last bugs go away. I would
>> even consider putting this patch this into fixes if it solves the problem.
>>
>>> although you may experience
>>>> performance regression with that:
>>>>
>>>>       https://marc.info/?l=linux-mmc&m=150589778700551
>>>
>>> Hmm. The performance of this is already pretty bad, I really hope it
>>> does not get any worse.
>>
>> Did you use bounce buffers? Those were improving performance on
>> some laptops with TI or Ricoh host controllers and nothing else was
>> ever really using it (as can be seen from the commit).
> 
> Thinkpad X220... how do I tell if I was using them? I believe so,
> because I uncovered bug in them before.

You are certainly using bounce buffers.  What does lspci -knn show?
