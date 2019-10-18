From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
Date: Fri, 18 Oct 2019 16:57:32 +0530
Message-ID: <ceb94a3f-9785-9fc7-b9e5-35435df9b498@ti.com>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Asutosh Das <asutoshd@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,

On 18/10/19 4:28 PM, Ulf Hansson wrote:
> On Mon, 14 Oct 2019 at 20:37, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Add a write memory barrier to make sure that descriptors are actually
>> written to memory before ringing the doorbell.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Applied for fixes and by adding a stable tag, thanks!
> 
> BTW, do you have a valid commit that it fixes?
> 
You can add:

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Thanks,
Faiz
