Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1F3559D6
	for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977208; cv=none; b=SCihmRXVBZHeKouNNtc1kIzWsvha06xNmejohJytms+pTqHjgWrEkC3St1cl6/Q3bQqfWV6edS566u2h6WD2cDMfd9iz4WG03J8wCAfOE2hascF7u4WmiRhM0vZmelQ5BsnPaH24zXLmYVUQCvy7pQUh/XNPvkpAbUw3rd1rC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977208; c=relaxed/simple;
	bh=32NrmXH9Vsmw2N1F2SLSyk8oTsLvpCiP90z+KAgZXFM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NGN5aNEvJNUooxRSJa542/ujzV4VrBihwnQnb078TNbc6abM/cTsKvGxSYa92g98KVy0FHtYeY1DZxGyqbqU15po6ZfK9fNvtxLzR4PLuUodplcEfk9+umWvydX5Dr0DSbveQHpzKsFbVMYeCgkxY6AG7thB7QSk5HNSxt2WmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPekytlN; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPekytlN"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=32NrmXH9Vsmw2N1F2SLSyk8oTsLvpCiP90z+KAgZXFM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789977203; v=1; x=1790582003;
 b=oPekytlNXG9Z5ueRHgUmz25qKzIRQi1UU96C+Cr4dyinP6DSJzTEmocfyCThtf3skn8QUJ1V
 QTyf+uHvkg0Tf9dCYnGzaStdN16/1+da4x7zV4w/LKNJgCz8RVxmVnNvBVKo7/zhmAonteWWd+/
 sst/biBDnhyEw163f+5PabKA=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 00947d7dc7e59382;
	Mon, 21 Sep 2026 07:53:13 +0000
X-Mizu-Trace-ID: 00947d7dc7e59382
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d135368-6b2c-443c-a946-45f0be2040fb@linux.dev>
Date: Mon, 21 Sep 2026 15:53:08 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Ulf Hansson <ulfh@kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?6ZmI5paH6LaFIChXZW5jaGFvIENoZW4p?= <Wenchao.Chen@unisoc.com>,
 =?UTF-8?B?5byg5aaC5rOJIChSYWluIFpoYW5nKQ==?= <Rain.Zhang@unisoc.com>,
 =?UTF-8?B?5ZSQ5pyI5p6XIChZdWVsaW4gVGFuZyk=?= <yuelin.tang@unisoc.com>,
 "cixi.geng@linux.dev" <cixi.geng@linux.dev>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v2] mmc: core: Optimize polling delay in
 __mmc_poll_for_busy()
To: =?UTF-8?B?5p2O5pmT5rSBIChYaWFvamllIExpLzEzMjMzKQ==?=
 <xiaojie.li2@unisoc.com>
References: <308e39324361468db136bb14a22f422b@zeshmbx09.spreadtrum.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <308e39324361468db136bb14a22f422b@zeshmbx09.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/20 Sun 13:40, 李晓洁 (Xiaojie Li/13233) wrote:
>> No, that's the whole point. We don't want open coded polling loops, it's just a nightmare to maintain. Please try to extend the existing
>> __mmc_poll_for_busy() instead.
> 
> Hi Uffe,
> 
> Following your suggestion to extend __mmc_poll_for_busy() instead of using open-coded polling loops, here is the proposed optimization.
> 
> In our actual testing, we found that setting udelay_max = 8000 (8ms) is more time-efficient than udelay_max = 10000 (10ms).
> For CMD1 (SEND_OP_COND), the polling intervals are 4ms, 6ms, and 8ms, capped at a maximum of 8ms.
> Attached are the recorded per-boot phase latencies for udelay_max=8000 (8ms) and udelay_max=10000 (10ms), with timestamps in seconds.
> Please let me know if you cannot open the attachment, and I will resend it.
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c

I think the CMD1-specific branch can be avoided altogether. The reason
CMD1's tail latency is high is that __mmc_poll_for_busy() limits udelay
to a maximum of 32768 and, more importantly, the sleep upper bound is
udelay * 2.

Would it be possible to parameterize the maximum delay instead? E.g.

   int __mmc_poll_for_busy(host, period_us, udelay_max_us, timeout_ms, 
cb, cb_data)

and limit both the backoff step and the sleep upper bound to
udelay_max_us:

   unsigned int sleep_max = min(udelay * 2, udelay_max_us);
   usleep_range(min(udelay, udelay_max_us), sleep_max);

Then mmc_send_op_cond() passes its own maximum delay (8ms), while all
other callers keep passing 32768 so their behaviour is unchanged. That
is two lines of code, no busy_cb pointer comparison, and the tail bound
(8ms) is actually tighter than the linear +2ms schedule (10ms).

Could you try to see if the linear step is still needed once the sleep
upper bound is limited to the maximum delay?


> index a952cc8..9c4762c 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -539,9 +539,23 @@
>   
>   		/* Throttle the polling rate to avoid hogging the CPU. */
>   		if (busy) {
> -			usleep_range(udelay, udelay * 2);
> -			if (udelay < udelay_max)
> -				udelay *= 2;
> +			/*
> +			 * Special delay handling is required for mmc_send_op_cond;
> +			 * otherwise, for slower memory particles, the time required to
> +			 * wait for the status change will increase.
> +			 */
> +			if (busy_cb == __mmc_send_op_cond_cb) {
> +				udelay_max = 8000;
> +				usleep_range(udelay, udelay + 2000);
> +				if (udelay < udelay_max)
> +					udelay += 2000;
> +				else
> +					udelay = udelay_max;
> +			} else {
> +				usleep_range(udelay, udelay * 2);
> +				if (udelay < udelay_max)
> +					udelay *= 2;
> +			}
>   		}
>   	} while (busy);
> 
> 
> Best regards,
> Xiaojie.Li
> 
> -----邮件原件-----
> 发件人: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> 发送时间: 2026年9月11日 23:47
> 收件人: 李晓洁 (Xiaojie Li/13233) <xiaojie.li2@unisoc.com>
> 抄送: Ulf Hansson <ulfh@kernel.org>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; 陈文超 (Wenchao Chen) <Wenchao.Chen@unisoc.com>; 张如泉 (Rain Zhang) <Rain.Zhang@unisoc.com>; 唐月林 (Yuelin Tang) <yuelin.tang@unisoc.com>; cixi.geng@linux.dev
> 主题: Re: [PATCH] mmc: core: Modify the CMD1 transmission interval
> 
> 
> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On Fri, Sep 11, 2026 at 4:45 AM 李晓洁 (Xiaojie Li/13233) <xiaojie.li2@unisoc.com> wrote:
>>
>> Hi Uffe:
>>          Thank you for your reply.
>>          However, I noticed that __mmc_poll_for_busy() and mmc_poll_for_busy() are invoked either directly or indirectly by many other functions within the MMC driver.
>> Modifying them directly could potentially introduce unintended side effects.
>>
>>          Would it be acceptable to implement a dedicated function specifically for CMD1? We could create a CMD1-specific variant based on the existing __mmc_poll_for_busy().
>> This approach would significantly minimize the potential impact on the rest of the codebase.
> 
> No, that's the whole point. We don't want open coded polling loops, it's just a nightmare to maintain. Please try to extend the existing
> __mmc_poll_for_busy() instead.
> 
> And next time, please don't top post.
> 
> [...]
> 
> Kind regards
> Uffe

