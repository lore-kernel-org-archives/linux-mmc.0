From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 0/4] Add tracing for SDHCI register access
Date: Thu, 18 Apr 2019 09:24:16 +0300
Message-ID: <bd3a1df1-5ac4-e23c-35a3-78361a5c356e@intel.com>
References: <20190411220822.81845-1-rrangel@chromium.org>
 <7b77ebcb-b42b-2d14-f5f1-b37e07b88469@intel.com>
 <20190412145012.GA101407@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412145012.GA101407@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@chromium.org, zwisler@chromium.org, Ludovic Barre <ludovic.barre@st.com>, Steven Rostedt <rostedt@goodmis.org>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Liming Sun <lsun@mellanox.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ingo Molnar <mingo@redhat.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 12/04/19 5:50 PM, Raul Rangel wrote:
> On Fri, Apr 12, 2019 at 09:26:44AM +0300, Adrian Hunter wrote:
>> On 12/04/19 1:08 AM, Raul E Rangel wrote:
>>> I was debugging a SDHC hardware bug and got tired of having to
>>> translate the register values by hand. This patch set makes it so all
>>> SDHC register read and write operations can be traced and easily read by
>>> a human.
>>
>> While this might be useful for people unfamiliar with SDHCI, I am not sure
>> it should be in the upstream kernel.
> Can you help me understand your hesitation? Would you prefer removing the
> pretty printing? Or would you prefer not having any trace events at all?

It is just cost/benefit.  I am not sure the cost of maintaining it is worth
the benefit of having it upstream.

> The xhci driver has a bunch of pretty print trace events that make it
> invaluable when debugging.
> https://github.com/torvalds/linux/blob/d7563ca5bfca53398e100eb74345c5d3ef06bf9d/drivers/usb/host/xhci.h#L2160
> 
>> Also, it doesn't seem ideal for every
>> driver to add its own plumbing for such a feature.
> What do you mean by every driver having to add it's own plumbing? Any
> driver that uses sdhci_readX or sdhci_writeX get the functionality for
> free.

I/O memory mappings are recorded for devices. e.g. /proc/iomem so it could
be possible to add tracing for all I/O memory accesses via readx/writex etc,
configurable / filterable by device id.
