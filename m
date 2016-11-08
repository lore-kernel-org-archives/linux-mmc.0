From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci-core: Tuning mode support for HS200 on AMD
 Platforms
Date: Tue, 8 Nov 2016 11:45:05 +0200
Message-ID: <09915eb8-f4c0-fbf3-723d-66441f0e4b7d@intel.com>
References: <2ef1e2da-5913-85fe-65a7-0984ac04164d@amd.com>
 <418f99e4-18e5-38a6-0b4d-0815f3bd604f@intel.com>
 <8510d441-230a-9d93-222b-ba870869f094@amd.com>
 <CAPDyKFoghPtP0Yff68k7gc+GxUo6uoqb1ucYPFWpEMReGM7Auw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57022 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752510AbcKHJuC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Nov 2016 04:50:02 -0500
In-Reply-To: <CAPDyKFoghPtP0Yff68k7gc+GxUo6uoqb1ucYPFWpEMReGM7Auw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 07/11/16 14:00, Ulf Hansson wrote:
> On 27 October 2016 at 11:52, Shyam Sundar S K <ssundark@amd.com> wrote:
>> Made changes to the earlier submission based on the comments
>> received from Adrian.
>>
>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>>
>> Also, adding patch from Adrian for handling the device specific
>> private data.
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Mon, 10 Oct 2016 10:04:45 +0300
>> Subject: [PATCH] mmc: sdhci-pci: Let devices define their own private data
> 
> Shyam,
> 
> Seems like this should be two separate changes, one made by Adrian and
> one by you. Can you please re-spin.

Yes, 2 separate patches please.  I didn't mean mix the patches together -
sorry if there was confusion.

