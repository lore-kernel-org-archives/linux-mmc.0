From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Wed, 10 Feb 2016 16:32:45 -0800
Message-ID: <56BBD6AD.2090902@caviumnetworks.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <56BB7B2F.60307@caviumnetworks.com> <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, linux-mmc@vger.kernel.org, david.daney@cavium.com, ulf.hansson@linaro.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zubair.Kakakhel@imgtec.com, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On 02/10/2016 03:49 PM, Aaro Koskinen wrote:
> Hi,
>
> On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
>> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
>>> +		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
>>> +			node->full_name, legacy_name);
>>
>> I don't like this warning message.
>>
>> The vast majority of people that see it will not be able to change their
>> firmware.  So it will be forever cluttering up their boot logs.
>
> Until they switch to use APPENDED_DTB. :-)
>

I am philosophically opposed to making the DTB an internal kernel 
implementation detail.

For OCTEON boards, it is an ABI between the boot firmware and the 
kernel, and is impractical to change.

One could argue that many years ago, when the decision was made (by me), 
that we should have opted to carry in the kernel source code tree the 
DTS files for all OCTEON boards ever made, but we did not do that.  Due 
to the non-reversibility of time, the decision is hard to reverse.

In the case of this MMC driver, the only real difference is that two 
properties have legacy names that later had differing "official" names. 
  The overhead of carrying the legacy bindings is very low.

David.
