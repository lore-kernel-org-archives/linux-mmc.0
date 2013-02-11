From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: sdhci: check voltage range only on regulators aware of voltage value
Date: Mon, 11 Feb 2013 12:27:11 -0500
Message-ID: <87bobqrcb4.fsf@octavius.laptop.org>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
	<1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
	<510BD3D7.1090302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <510BD3D7.1090302@samsung.com> (Marek Szyprowski's message of
	"Fri, 01 Feb 2013 15:40:23 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Kevin Liu <keyuan.liu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Marek,

On Fri, Feb 01 2013, Marek Szyprowski wrote:
> On 12/4/2012 3:01 PM, Marek Szyprowski wrote:
>> Some regulators don't report any voltage values, so checking supported
>> voltage range results in disabling all SDHCI_CAN_VDD_* flags and
>> registration failure. This patch finally provides a correct fix for the
>> registration of SDHCI driver with all possible voltage regulators:
>> dummy, fixed and regulated without using regulator_count_voltages()
>> hacks.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Any chance to get this patch scheduled for v3.9?

This one doesn't apply -- please could you rebase/resend?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
