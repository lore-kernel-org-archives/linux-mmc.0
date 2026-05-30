Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8586274FDC
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167816; cv=none; b=oA4XR1yYiuPWTHc4GG12zhuBBrFwJVzBnEeE8LTpEk9gsOWJfh5aT6/6zQIyN74saYuw6cFJN9x8djUxQ5HqC/IT/VCLxHxRPp/rxiMVv8qnVtgygRTfU+Xk6jx+sQV7qzACymhSgckm62M0j1CGXde6B0CCbOaObXGugypgUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167816; c=relaxed/simple;
	bh=SU5OJD9r1W6TDFzJRNMyWL6HpkKIFP7cuST3dypaF6M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=snRcqiMQgAs09KdNFWVhLoId6wta75YvYp00fNOhE7ssp9JEsoUUnzis6qChjUDGQt8s3RJeYrJAPpvRGl9RQiAiTMBMsgPkueTOyZ+I6rb1T5w5wZMolBxX3FIqo8EZ+hoa/bbE5a7XRcAbaRvtkkftotNRj6ieCl/9lNhn5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.17.160) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 30 May
 2026 22:03:22 +0300
Message-ID: <ec7fd02b-9124-49bb-88c7-3482261e8a94@auroraos.dev>
Date: Sat, 30 May 2026 22:03:22 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the, probe() method
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Language: en-US
In-Reply-To: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Hello!

   Oops, a stray comma sneaked into the subject again (I had to use Thunderbird again)...

MBR, Sergey

