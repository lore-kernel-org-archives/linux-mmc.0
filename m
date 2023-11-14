Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9377D13FFE
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0v8gkrV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1241B2;
	Tue, 14 Nov 2023 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699950310; x=1731486310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZsluGkovvLZGSDBjAzFoyP9oHyQ46jeHVYC5LAYknI0=;
  b=a0v8gkrVcIagCXjhVf0jI3q0Fw+vrzs3joGsa4+zxeN8orUV2ihaV22f
   iGp+E7kfxUW+vz4r/ZxVpOzM+GL9XjyphibQwpUV0fQ+HBO+z37HQ0fLj
   LNF/1Cc0bujYJh7hCzXJ3Yw4ocXF7HGc46YCNc8awKoNlzAk6R1fR8evl
   fTbvdEEr5WpocMiRME9wuK9mC2Q/In8/KBx0MYaqEQnKLzBnDYAgAZHSS
   axTnLNIK1ImERsBWHg8qQK6/fMsmKi4kP3STI+MTgTugGqAyl7B+cVRQg
   dHAf5GbopeBb1EYfiQewChTxRpo0NRCyHKF8rawl4pDtdW/Vd9wVIIlvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389467475"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="389467475"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758099845"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="758099845"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.39.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:25:07 -0800
Message-ID: <df204135-f12b-4892-963c-a4c87b1dd3cb@intel.com>
Date: Tue, 14 Nov 2023 10:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SDHCI AM654 driver delaying boot time
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
 <20231109175159.wylup6z45h7mgxji@clump>
 <ZU4748HsFFMx/bsT@francesco-nb.int.toradex.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZU4748HsFFMx/bsT@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/23 16:19, Francesco Dolcini wrote:
> Hello Nishant,
> 
> On Thu, Nov 09, 2023 at 11:51:59AM -0600, Nishanth Menon wrote:
>> On 18:56-20231108, João Paulo Silva Gonçalves wrote:
>>> Hello all, 
>>>
>>> We are trying to minimize boot time for our AM62 devices.
>>> Unfortunately, we have identified a delay of approximately 1.5
>>> seconds caused by the sdhci_am654 driver. This delay is a result of
>>> a timeout within the driver (MAX_POWER_ON_TIMEOUT) and was
>>> introduced in commit 7ca0f16 ("mmc: sdhci_am654: Add workaround for
>>> card detect debounce timer"). This issue arises only when there is
>>> no SD card present in the MMC slot.  We tested the driver with a
>>> lower timeout value and everything worked. However, as indicated in
>>> the commit message, this timeout may be related to the way the sdhci
>>> controller hardware IP works. Currently, the driver employs a sort
>>> of a "busy loop" to wait for this timeout to pass delaying the boot.
>>> Why is need to busy loop for this timeout? Is it possible to wait
>>> for it in the backgroud? Am I am missing something here? 
>>
>> I am not an mmc expert, but, Isn't this sequence part of the programmer
>> manual in the TRM[1]?
> 
> Probably original question from Joao was not fully understood.
> 
> It is clear why the code is waiting for the CD, the issue we are
> experiencing is that the whole boot is delayed by 1.5 seconds because of
> that piece of code for no reason.
> 
> - SD card exists in the system, but it's not used and the card slot is empty
> - We boot from eMMC (that has no CD pin)
> - Boot is delayed by 1.5 second because of that piece of code

So maybe don't use that code for eMMC?

