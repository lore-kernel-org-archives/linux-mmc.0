From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC broken in kernel 4.4
Date: Thu, 3 Mar 2016 17:45:39 +0200
Message-ID: <56D85C23.5060208@intel.com>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
 <56D44249.7070200@kernel-upstream.org>
 <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
 <56D4FCC2.1020604@kernel-upstream.org>
 <hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>
 <56D56ABA.5020206@kernel-upstream.org> <56D6D4AC.40205@intel.com>
 <hubert_tonneau/RM1SK4J9/0G37PAN@hubert-tonneau.storga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65462 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbcCCPpm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2016 10:45:42 -0500
In-Reply-To: <hubert_tonneau/RM1SK4J9/0G37PAN@hubert-tonneau.storga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: Shawn Lin <shawn.lin@kernel-upstream.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <Baohua.Song@csr.com>

On 3/03/2016 12:29 p.m., Hubert Tonneau wrote:
> Adrian Hunter wrote:
>>
>> It might also be related to the problem here:
>>
>> 	http://marc.info/?l=linux-mmc&m=145319732219412
>>
>> You might try keeping the patch and applying the two referred to above.
>
> Hi,
>
> Stock kernel 4.4.3 with the two extra patches does not work.

Yeah, sorry, they are not related.
