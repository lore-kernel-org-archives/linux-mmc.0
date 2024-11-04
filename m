Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6E1C243C
	for <linux-mmc@vger.kernel.org>; Mon,  4 Nov 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734874; cv=none; b=TTALa5o6CVVscdazfqTfeIhHwAdwM+YOZkZxclRsaD0So8MCpHr8glkJ3H8aQFM4PyhQZXM1sEq5Iw1ZUs7I3oOuv48KzXLw8mpPb1a2hqZl92qGEqFghcvOO+c+X//oCOJdZZr4xT0T/ibCNAc7ihClUYPdqsNwuNK45OKcc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734874; c=relaxed/simple;
	bh=2/TVkVyGg9SMBHGoekqwjWlFbZIZyCUeB3LECQtAzm4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rs4v/89O9tky9OGyFVZkMwipDol0A7pP6MAbbFTVbMvWu3JZUNQCiSPoWRo4yqU4e5v6uvMFPCzRyQmvLPIROtvZensqvbKK871DF18jBLGFGaJAuAVZpi0n0BJb+DrOSBs53NGENS35FM7fqOs3U/pnLgy/dDMGUVv+PV/gXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sss+PP61; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sss+PP61"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso9613883a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2024 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730734871; x=1731339671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOXglObfnAnhBL3frBdzCWvPAMNA4tpUfFPAYRRKgbo=;
        b=Sss+PP61+i2ScV4QVHYo2VGmsNpK8tGnCEIaiNvRnOqjdTaVi0F2UVu+knkbJtqb20
         8mHXi5dV9w3eT0gU9RMLQIBzdQMn+wST34Uga5RBaJiGKKYlu4iQyFjXIcbJ/HtoQiff
         4GZQLTyhK2eAImpYAmG/MRfvgNmKhhexQeDD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734871; x=1731339671;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOXglObfnAnhBL3frBdzCWvPAMNA4tpUfFPAYRRKgbo=;
        b=OX+2tOztPwbH5nAgFN5Qyg1MmSY8RiuNGXBoRnTmggGA4QPXucdGVcurf2UGO+JvWk
         ut1ao23gUZCjcpNe1roeYbbt0CC4nB4qpbaJMWLrlGqSsNvOlmRTskzzqPgdsg5g6DLm
         tYyggIoWT1hw8uodZRDBuiZBsi2NqLmifjVrPZZEu7irArF1DgglaEnBC1yXx0P/O+OV
         lUpN6fCaYy03f+w2mMYpBlymM8qPhsEKablf3bOwRJoJckn99wY/Bh1+/h71n4ZOuaL1
         JYnwQyYICqWNjqvsYYN17I4VjU099dBRB0hCBM7h/ky03RYOXM050fAzmVYp8oIqUxIw
         jdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjopPgNlK50PVYCxmPZlGWekkdQMsBfCeTgsJjYI5qh/CUQ11VVctkjThKuhafZ25WqlSJXHxW3KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/9UoWzdtgSo+1LbupzmKzGfAI4jEZX6tvtDkcsU5SLSxESK0
	uazw02WzGSjJSco2ajyd5bdJXbb5gzV6u+bpGH+g7KQ2cSg/R+hyXNznRgvojw==
X-Google-Smtp-Source: AGHT+IE36xk8PmLNdKkgHOVWci4w9T24kW7T9I6LD7JitrCFEgmN98YmaezOS6Dw4H/xrClhKfClmw==
X-Received: by 2002:a17:907:7e8b:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-a9e653828camr1266220766b.17.1730734871504;
        Mon, 04 Nov 2024 07:41:11 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56493e40sm564177866b.40.2024.11.04.07.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:41:11 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Kalle Valo <kvalo@kernel.org>, "linux-mmc" <linux-mmc@vger.kernel.org>
Date: Mon, 04 Nov 2024 16:41:10 +0100
Message-ID: <192f7d64df0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
 <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
 <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: brcmfmac: error messages while entering suspend
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 4, 2024 1:18:44 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Mon, 2024-11-04 at 12:59 +0100, Stefan Wahren wrote:
>>
>>>> [  384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we have
>>>> nothing to do.
>>>> [  384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-5)
>>>>
>>>> These errors are not new and I assume they have always been there. I'm
>>>> not an expert here, so I want to know is the problem here that the SDIO
>>>> interface is shutdown before brcmfmac is suspended or lies the issue
>>>> within brcmfmac suspend itself?
>
>>> Upon suspend we execute the remove path and cleaning the interfaces.
>>> We notify cfg80211 about the removal, which in turn will notify
>>> userspace, but is tries to obtain the tx power from brcmfmac.
>
> I guess "it tries to obtain" is some sort of event path that wants to
> include the TX power in an event. That doesn't seem to make all that
> much sense on removal events though, so perhaps we could remove the
> get_channel and get_tx_power calls for NL80211_CMD_DEL_INTERFACE.

That's what I was considering.

>
>
>>> However,
>>> at this stage the communication with the dongle is already gone. These
>>> messages are also seen in the module unload scenario. It seems a bit
>>> redundant to query a device that is going to be removed. So it could
>>> be fixed by chiming down those message or avoid it completely by
>>> changing the behavior in cfg80211.
>
>> chiming down all the affected messages (i reported only one example
>> here) sounds strange to me. Maybe Johannes has also a opinion about this.
>
> Dunno about the messages, I mean it's still possible to get those
> messages when e.g. userspace manages to query just while it died, so
> perhaps you wouldn't want to print it for all cases, but OTOH that's not
> going to happen all the time.
>
> But I don't have much opinion on driver messages :)

Sure. The two messages mentioned above are the ones I meant with coming 
down. Not all driver messages. At least the message in brcmf_fil_cmd_data() 
is not very useful. Could just be a debug print iso error print.

Regards,
Arend


