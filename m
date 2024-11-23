Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4E16FF44
	for <linux-mmc@vger.kernel.org>; Sat, 23 Nov 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732355500; cv=none; b=YN5ypfBtcxiydVKbnQ3PWmqq02owzN4FsYc4fLGTzDz3KjpTKLoXxRkfssW5GodA193x/WdpnklVnUu/dzA3zVCG2QIyAUdrgzQ+7/qtYUciwThwAe9sEm1EbygVeE/f5XQJ4kWWuyB6x82xmE6iPI6sNC+gkGXcAg/VaNRHoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732355500; c=relaxed/simple;
	bh=5mFgvHfxxqyIok4KkeF5i1Dm8sfAGAB7oh8z6PGyMtk=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MeEduabjXsyVSI98BDo/YHioT+E5MXj4JGsd5EvD9CWJKFVDeVLk7EgCJT9pPz2SU7vU9eoHjtkZW0PEQgKvUWLH6Zr57+savWXgbp+OirUYRAcn7PNM0EotjTYMv2JyVQM0rp4N8EoV6sgRzkVtPyNhX7g9XGNT/p7IW9c938E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qw84sjbr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qw84sjbr"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso410787366b.3
        for <linux-mmc@vger.kernel.org>; Sat, 23 Nov 2024 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732355495; x=1732960295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2He4Y+3l6zjnzsCvPiyzHE8Ux0qLZfdpjc2IjiyYS9Q=;
        b=Qw84sjbrYsHpizdtgyilRz7xUzWByLC4QIvYxWJ7ob8+TX3s0ZasARIAc5ljkw+ibu
         pymgE9MmpH2OwaZz3//h5lbq8CgCQaYFVz3rziT3qwtU0sgqBWK/WPZ4vl2rylADg6Am
         CG1x3sX5NiVAhQPQWIJ9eXcvlEvrB1l736KTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732355495; x=1732960295;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2He4Y+3l6zjnzsCvPiyzHE8Ux0qLZfdpjc2IjiyYS9Q=;
        b=J2v1PP/ez6qpcG0eIn4rq1KU95DYtAMekQFlaylsP1rr1SCnkXS67K19JtyjGY36n3
         uX/wqaXbPJJIR7Hh03WU+IuU8bxt1cz77veioMW3eQp0iULWE6qmb444m9FlAhhARIE+
         MrPP6wRXT1Y1U/3bsa3U5FxQDTtx0w+lj6sP3VvtHc6VVzvAt/pDpJB7qCMbGa3laUYx
         NJwQt7VsYj4RezwJ75gkkZXwiFG85Fn4YvMoELPvrKdEtphVsng7ELTRjivUnIEmNIwp
         c31j9e+WoVENdwKHfge83g5o3XdS1bKXsn6hIlRQ77JpusJm8VY+iDUyFFSrOdqXP5UC
         lXbg==
X-Forwarded-Encrypted: i=1; AJvYcCW9alpVJm0Uw9rNsI05CwQxwlkfHt2uWeEgv0WitY9gqGWCIDlmq9aF+dvbEmr94zdokg6nrXZHywA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IlJ7GRBRjYpKJ5sHRU/upwBi9bNxh4KDdlIBwBk5lLt/HJmP
	x30SvufKPEC0GZKsRaVcw8DglxLRHHtoPozmq//98PlOi0oiN2lO0sSBNbFIeg==
X-Gm-Gg: ASbGnct5+0DSVMYXye0UaR229WgYI+4Bq9II3F0NAPONfWShS2Y7HJrpWeYbphLUDhi
	oaaYAZqwu1DtE6Oq2wRoJbZUsfFd1p3ibZPeGgOjl8o/ejXaMRBa3s/n9wRlkTB+wsOeycfx3Gh
	9e5sLwV+mE6MP5UIrgVO9oz8o0F8RYwkPMAdcxdZTnn5uRPpevG9uHsV04zdwO1ms8wPkiH86yp
	Qqta4HB6JdVPwUjQqz2Vj9RC+b5kyFw9TP4FmdeuEPeTMGC6pOMtksFsN+UPX5orU0GPyykHJ8u
	PsgUB6ckXNqv
X-Google-Smtp-Source: AGHT+IFq7oIJo3gucR1f2TVQm30JKlJTgPGnpog1fqvObzxkCV1gj1+y+gfxLL9E/8hQlX2VlIl+uQ==
X-Received: by 2002:a17:906:bfea:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-aa509e94d2emr437231166b.61.1732355495522;
        Sat, 23 Nov 2024 01:51:35 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fa20sm202775966b.113.2024.11.23.01.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 01:51:35 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Stefan Wahren <wahrenst@gmx.net>, Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Kalle Valo <kvalo@kernel.org>, "linux-mmc" <linux-mmc@vger.kernel.org>
Date: Sat, 23 Nov 2024 10:51:35 +0100
Message-ID: <193586f1458.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <a122ad79-086b-42a9-894e-d589092bac80@gmx.net>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
 <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
 <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
 <a122ad79-086b-42a9-894e-d589092bac80@gmx.net>
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

On November 4, 2024 9:06:04 PM Stefan Wahren <wahrenst@gmx.net> wrote:

> Hi,
>
> Am 04.11.24 um 13:18 schrieb Johannes Berg:
>> On Mon, 2024-11-04 at 12:59 +0100, Stefan Wahren wrote:
>>>>> [  384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. we have
>>>>> nothing to do.
>>>>> [  384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: error (-5)
>>>>>
>>>>> These errors are not new and I assume they have always been there. I'm
>>>>> not an expert here, so I want to know is the problem here that the SDIO
>>>>> interface is shutdown before brcmfmac is suspended or lies the issue
>>>>> within brcmfmac suspend itself?
>>>> Upon suspend we execute the remove path and cleaning the interfaces.
>>>> We notify cfg80211 about the removal, which in turn will notify
>>>> userspace, but is tries to obtain the tx power from brcmfmac.
>> I guess "it tries to obtain" is some sort of event path that wants to
>> include the TX power in an event. That doesn't seem to make all that
>> much sense on removal events though, so perhaps we could remove the
>> get_channel and get_tx_power calls for NL80211_CMD_DEL_INTERFACE.
> Not sure if I get it right, but the follow patch make the errors go away:
>
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 1ac8a196f376..52120cce2f7e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -4006,23 +4006,25 @@ static int nl80211_send_iface(struct sk_buff
> *msg, u32 portid, u32 seq, int flag
>          nla_put_u32(msg, NL80211_ATTR_VIF_RADIO_MASK, wdev->radio_mask))
>          goto nla_put_failure;
>
> -    if (rdev->ops->get_channel && !wdev->valid_links) {
> -        struct cfg80211_chan_def chandef = {};
> -        int ret;
> +    if (cmd != NL80211_CMD_DEL_INTERFACE) {
> +        if (rdev->ops->get_channel && !wdev->valid_links) {
> +            struct cfg80211_chan_def chandef = {};
> +            int ret;
>
> -        ret = rdev_get_channel(rdev, wdev, 0, &chandef);
> -        if (ret == 0 && nl80211_send_chandef(msg, &chandef))
> -            goto nla_put_failure;
> -    }
> +            ret = rdev_get_channel(rdev, wdev, 0, &chandef);
> +            if (ret == 0 && nl80211_send_chandef(msg, &chandef))
> +                goto nla_put_failure;
> +        }
>
> -    if (rdev->ops->get_tx_power) {
> -        int dbm, ret;
> +        if (rdev->ops->get_tx_power) {
> +            int dbm, ret;
>
> -        ret = rdev_get_tx_power(rdev, wdev, &dbm);
> -        if (ret == 0 &&
> -            nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
> -                DBM_TO_MBM(dbm)))
> -            goto nla_put_failure;
> +            ret = rdev_get_tx_power(rdev, wdev, &dbm);
> +            if (ret == 0 &&
> +                nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
> +                    DBM_TO_MBM(dbm)))
> +                goto nla_put_failure;
> +        }
>      }
>
>      switch (wdev->iftype) {
>
> But this change doesn't consider get_txq_stats and the further calls
> rdev_get_channel for the valid_links.
>
> Do we actually need nl80211_send_iface() for NL80211_CMD_DEL_INTERFACE?

In term of user-space API the answer would (probably) be yes. At least the 
primitive should be send. What attributes should be included is debatable. 
The primitive is probably used by user-space to cleanup or disable 
functionality using the given interface. So only attributes identifying the 
interface are likely sufficient (wdev-id, if-index).

Regards,
Arend





