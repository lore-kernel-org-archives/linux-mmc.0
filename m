From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Date: Mon, 13 May 2019 09:44:36 +0300
Message-ID: <e2341ef7-134d-7eed-bb86-e1a341ea8914@intel.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
 <495b70a3-0232-343b-9081-56869415986f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <495b70a3-0232-343b-9081-56869415986f@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, Raul E Rangel <rrangel@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
List-Id: linux-mmc@vger.kernel.org

On 12/05/19 8:04 PM, S-k, Shyam-sundar wrote:
> On 5/2/2019 12:02 PM, Adrian Hunter wrote:
>> Cc: some AMD people
>>
>> On 1/05/19 8:54 PM, Raul E Rangel wrote:
>>> AMD SDHC 0x7906 requires a hard reset to clear all internal state.
>>> Otherwise it can get into a bad state where the DATA lines are always
>>> read as zeros.
>>>
>>> This change requires firmware that can transition the device into
>>> D3Cold for it to work correctly. If the firmware does not support
>>> transitioning to D3Cold then the power state transitions are a no-op.
>>>
>>> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
