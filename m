From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC broken in kernel 4.4
Date: Wed, 2 Mar 2016 13:55:24 +0200
Message-ID: <56D6D4AC.40205@intel.com>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
 <56D44249.7070200@kernel-upstream.org>
 <hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
 <56D4FCC2.1020604@kernel-upstream.org>
 <hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>
 <56D56ABA.5020206@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:24087 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682AbcCBL7B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2016 06:59:01 -0500
In-Reply-To: <56D56ABA.5020206@kernel-upstream.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: Shawn Lin <shawn.lin@kernel-upstream.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <Baohua.Song@csr.com>

On 01/03/16 12:11, Shawn Lin wrote:
> Thanks for testing and plus Barry.
> 
> So Ulf, I can't remember we have a fix into 4.4#[-rc*] for it, right?
> How about take this changes into more consideration?
> 
> From the changelog, it's modified for SD 3.01 which makes bus test
> a mandatory requirement. But how mmc stack know its version is  3.0 or 3.1 ?
> 
> On 2016-3-1 17:46, Hubert Tonneau wrote:
>>
>> Hi,
>>
>> With the patch reversed, 4.4.X kernel works on Lenovo Yoga 8 tablet, just
>> like kernel 4.3.X

It might also be related to the problem here:

	http://marc.info/?l=linux-mmc&m=145319732219412

You might try keeping the patch and applying the two referred to above.

>>
>> Shawn Lin wrote:
>> >
>> > Do you have this part of code[0] in your repository?
>> >
>> > [0]: https://patchwork.kernel.org/patch/7323541/
>>
>> Regards,
>> Hubert Tonneau
>>
> 
> 

