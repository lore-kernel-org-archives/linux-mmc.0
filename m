Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFD3E0C57
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954703; cv=none; b=WyzhOgijRwr4OsF6DFuO3jXms31YZhVw745cqME4AqYJOAsmJVVHqn/EVoyudks8l6hdYToG3Yr9S+ozmVAcRES6LfRG5fqUMsVKVDLVn8ZRRIvlw9W3X6Cw2q9ziUcRhCMbnMdonPGaLiDwtS2UKPNWT3Q626fNYMs4+H5cgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954703; c=relaxed/simple;
	bh=mTJPRgnNDEJNnPcBkxqq2XPyMZa213ryBi7CV4IZV7U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSB8B5b2WDkGI/BzaPWQBw4iSZaXVNGxChNJf80Dj8RybMG0k/QhDVX1FtP2/Q5OwmururLZO1ozowBZtKw6QCp7Kx7LciAroH+G3vJJXOHegOtAqD9g7BnewkoeXg8N/S79qmmlJzO73rHgkicdSuxZfZZIlJhxmWeFmA337wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=V0r6njdN; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="V0r6njdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783954688; bh=mTJPRgnNDEJNnPcBkxqq2XPyMZa213ryBi7CV4IZV7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V0r6njdN1kwwnTGWbiJMtU9pEhRqpkLBQkfbsESjG36FwN4q/kpiNYuiyL0kfUp3W
	 rbP2ivfbBtSR71BdSbZ9sflwsuvjc/sssYoilRDaZs873nI9nPGh9xKIkd5fOgWZiy
	 boQXCe/6HbUdgGor/GSXEnhjh8Z8Nt1A7BPYi+tc=
Received: from qq.com ([49.64.251.140])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E8599865; Mon, 13 Jul 2026 22:58:05 +0800
X-QQ-mid: xmsmtpt1783954685t4lof52pi
Message-ID: <tencent_B87ADA0AC8756D910EBF93B2F0D92348280A@qq.com>
X-QQ-XMAILINFO: M2SvzgchpLqfihnCn+WEuv3XQY2AF1+4ppooZ7HYXSH2M+1GcMHqY3FCHnU+oq
	 nq5kyxamxLIdsuGCoS2kK0e/PZbUDSk1DU1eEx8b5beWUE6doXo6qr99+ivJ4c7hXUuomp13TFdF
	 Qc+i7WfO+NHyuwqXx+WeCL2KmdXoKCXR69WQziihqfo8T/itZqHy1Qq1Ua2+L2Jno4QYWW3viLDJ
	 JOXs1NWPJtBEMbZYRXNmGD1Zy3bAHVF7Ez4vzwRFRwRnp0quC+6U4S+UyISHF8IlbbG0CJ2EIxnF
	 zg/KQYieOo9mN5VxBTFz/Y5yYqte85oWfgGTfr7dvlN0BLnTfP+MpOEd4cNTlC71LvKVXndVb1/4
	 Mg2uBeVE8QAy+UGB8KXZkMzRZ/oxv/R3Dg4KM3KYaR7XADAQe56b6M89CgTygeK8+oEdQsTIT4BU
	 5lTFCY1d5Kg8DFP55YpMEv15+iYuEqmml01CEqepigHeMGzQ2jVxPikkIr/mIeUCEAt2S92kgrO3
	 kA54pax1jR6ySbGvip1QJpldU09VevBrRI5nIJS5NKomQose4gtf+nyb7obclC+Q8cWWGUcTmtbi
	 vSLbTb+5TkRhGoZ48t+GJTCDr3HpcQJYMGUx93uZD8LI/7SgPc0JnkFsxjwA+HtHAxnCzB5WZuwQ
	 fONTdQsRsS0UXHOr2CW4qnNzAUwjOZZ0225+H9PbXhRvpeeK0guK6GbQ2/6eHcA3xTUTzWGxma5L
	 DCjW2tlgCHLwgBCYmnXurhO9IfJ3awDdRtOBkaH11EQiZw29cKJHWpYGG8bJTlHkYnGh834MAl2t
	 l5IUGKvl91FmqaavXq++fw8y13m44XNVuSOGt915YpPQoIpjGvJvKvGdsuAjNG5Zv4nGnhn0HNm1
	 MQzhgE9lcvgil8JMsx9Y1LWsMkuzMyONjHlQGnmUJUTOG2QuxmtPZIV0HZjMNE1UEhMtXullnbuv
	 eLZyAhTTAsqOqE2lzEB1waDRMdvDROP0fAkHh1vkPslgiKYLob9moyFU1uxqwcIfytpdMzAeUMTX
	 91oe8uO2Wn60WQ/gJk1CCh97f6wVaYLKWMsvbhag==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
Date: Mon, 13 Jul 2026 22:58:05 +0800
From: Wei Cheng <wei.cheng.kernel@qq.com>
To: avri.altman@sandisk.com, ulfh@kernel.org
Cc: linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
 database
X-OQ-MSGID: <alT8_WCq5e_S9w18@qq.com>
References: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>

On 2026-06-13 23:04, Wei Cheng wrote:
>The current sd_database does not contain an entry for ATP (Manufacturer ID 0x09).
>Add it so that lsmmc can correctly identify ATP SD cards.
>
>Verified on ATP AF4GUDI-OEM microSD.
>
>Signed-off-by: Wei Cheng <wei.cheng.kernel@qq.com>

Hi Maintainers,

Friendly ping. Could you please share any feedback or concerns regarding
this patch?

Best regards,
Wei Cheng

