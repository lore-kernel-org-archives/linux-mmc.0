From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
Date: Tue, 15 Oct 2019 16:45:43 +0300
Message-ID: <ca62cbaa-111c-4546-afd5-aad70eb98993@intel.com>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fac9ad28-dbc3-3948-d99c-742420f3e651@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 15/10/19 10:55 AM, Faiz Abbas wrote:
> Hi,
> 
> On 15/10/19 12:08 AM, Faiz Abbas wrote:
>> Add a write memory barrier to make sure that descriptors are actually
>> written to memory before ringing the doorbell.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>
>> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
>> I have been seeing after enabling command queuing for J721e.
>> Also looking at memory-barriers.txt and this commit[1],
>> it looks like we should be doing this before any descriptor write
>> followed by a doorbell ring operation. It'll be nice if someone with more
>> expertise in memory barriers can comment.
>>
>> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>>     doorbell")
> 
> So I see that cqhci_readl/writel() use readl/writel_relaxed() which
> seems to be causing this issue. Should I just fix this by converting
> those to readl/writel with memory barriers instead?

Perhaps we could do both changes i.e. add wmb() and convert to non-relaxed
readl/writel
