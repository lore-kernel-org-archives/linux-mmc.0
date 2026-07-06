Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652F3FD13A;
	Mon,  6 Jul 2026 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362362; cv=none; b=S5Bv7A4K22RRdhJ82y/IpQfg+iy9/z6JkdjE6yvCTrfpYw2WhtGjIQ+AuRQBJ0QCiAa+x9V9uzCFiEZgs8TgVIUO6VaH0ob0iuAJ9hcgrV7YzJBJossRILIZgY9I/24KlKb3kzL7YVZe/LCmsPYmUlmPb1L7eO/PfNRtgRa7anQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362362; c=relaxed/simple;
	bh=mt8/70lAQQoIPcEkfZ0zdHykksmIzJ8X2UemPSbx33A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tASGWh/spAPp+/o+FdFaphR/3hNCLKeh4iE5626Djng5ybrsdCD0ZyramyRkQpCSV4aOmtkJLiAorOhfTs1cCMsxifnEskqyXGat13u8EK71NGmMPmEYgSLUNHC+qKQRZtE6X5CwA6UnUSKq4RKzbDAjOiS4VkYOvhKOfn54p3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=zqk13lJ3; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="zqk13lJ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=H6AThd3qcsniqGh6BWU86mTPcw94NPfV5uV4aSYs0O0=; b=zqk13lJ3rDcVUTT8
	3Z5y6I0NTPIiiuFL8yIBW4v5Lhb0Zm+oc5u9OYobUygLsOERMQ4f5uYKb5s1SAiN1xEu4BNwZKixB
	eQt72cW2DUUYfdQfDf2//vLugr6QJcgh1vhROHnaPU1TkzFHV8AjtoT4S+6gP0cNencAVT1r1pI54
	dIBHkeFVZVs5GH186xFtyeknWqpKF2grgad9U6tVN4ucwLbdNO9T+fwvIxcxXsF4Tv8gahvG/YX1o
	t62dtwkP+ph5zvWf0QgdamtkikRgX3abZmrSxpSXkzeUdZ2OGF9Kjx7iftCpd+6jz7GKauxKny0QT
	uTCk5AKAhk/zScziFw==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wgo0s-00Gonv-2y; Mon, 06 Jul 2026 19:25:50 +0100
Message-ID: <80c8ef42-4c2b-4206-8cac-b2a32a4f2e6b@codethink.co.uk>
Date: Mon, 6 Jul 2026 19:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: add declaration of dw_mci_pmops
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260623102353.755235-1-ben.dooks@codethink.co.uk>
 <CAPx+jO9BtwN+=Y_xLFXusTwFFv=5KDZCY_3QmSpRmskMch3W6A@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAPx+jO9BtwN+=Y_xLFXusTwFFv=5KDZCY_3QmSpRmskMch3W6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 06/07/2026 15:30, Ulf Hansson wrote:
> On Tue, Jun 23, 2026 at 12:24 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>
>> The dw_mci_pmops is exported out of dw_mmc.c so add a declaration of
>> it in dw_mmc.h to fix the following sparse warning:
>>
>> drivers/mmc/host/dw_mmc.c:3512:25: warning: symbol 'dw_mci_pmops' was not declared. Should it be static?
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   drivers/mmc/host/dw_mmc.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 9ffcd3946cff..38610c89d54a 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -19,6 +19,8 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/workqueue.h>
>>
>> +extern const struct dev_pm_ops dw_mci_pmops;
>> +
> 
> It's already extern declared in drivers/mmc/host/dw_mmc-pltfm.h.
> Perhaps drop that then?

so just move it into dw_mmc.h?

> 
>>   enum dw_mci_state {
>>          STATE_IDLE = 0,
>>          STATE_SENDING_CMD,
>> --
>> 2.37.2.352.g3c44437643
>>
> 
> Kind regards
> Uffe
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
