Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE934908D1
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009504; cv=none; b=sFOPk/bdLMnrT8dloCQyhaBUKgN3+BkfLMboP7Z4RWFIKR8gKrFiqN2XGxyPL6LnHh3gHJjd20wouSBoJYzHouogJyEJpTEb+pL46sM53ZCy5o61bURHK7gXyio0D54nFIPtXoAwRpvyqSWSJ2nZIQHejUSSbLdpuhJ7B0e6dgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009504; c=relaxed/simple;
	bh=nW/2CYUliCpoe36rO5FycOqU8CpMiHRemZxrB0wzElM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD5oYWDTnBtxpHijibIYZcXwBRbZJ2qLA7ukSc/JtOPDpFaLP4ngzEz4eucuqrRKZxO075o4XskUS0BHFEj+8cL+XIiv2zsuvIII3CbNr9LRwQcgPZcSvFUPT5x86/EV7V3kDhZKPWd7sHNYrsJTocM47cI2PkP/n8MNTdZx8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf8tveLM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf8tveLM"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso4178629f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792009502; x=1792614302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4L9YzOnth9DsCZixyFf9BkVDmJ4QHvH7yn8J2G8kxV0=;
        b=Lf8tveLMp10X8aWoR9M+p2I/13SqdLcF3VK2MBoyupTZt3rVV2gZJWMvREr4FiJcEw
         BgAWqFosNOqKarUtvLZs0vwH28YT0sfjOHcwctjKvFzEMJeEko9jxbkLtkuX1l3MmbKp
         k5684USAWaLPvF0hkw7Z+h2aHHT3NKUqctVy3OfJKl0B0QxRyxuvIgFPy1HxvOyuJAhU
         bXdjmF19gVocHCTLay+wA2k/UqYz4arSuHxZLRXWvxrcAdjvpXe8yjNzv5/Bi3ujFAD4
         k4BIm9AGBdCQvPrxQs37dT4d48Sxee+zD+pX4HHJXQFkZ7fiWmxF84eE5kYFKU42ifwe
         0G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792009502; x=1792614302;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4L9YzOnth9DsCZixyFf9BkVDmJ4QHvH7yn8J2G8kxV0=;
        b=Su1ZKF6Uwexvbj3I2eUcCf5ig5anhKhxSg83O7gYMaE60Qt9qN9USyDgvDQJLGgLcM
         ftC1izHRUk/HqP3FWDE2ZsFpsPxT6L4O9lZ7VlQYLsvDv/+mfJ1QDanH9yynknIgSRQA
         TYUDk7DRAXtwZrAsVqbX43NlGfSfugMprIgk9B2qlgjdSYbyXiormN8GPHSUfUqUNsEI
         MtFOpPKDuxozmsSrBGs1tFxnFviSozupxoqlomQWfaU3dWFsmA/UYp4omo4WXFHxRJMV
         Kg2E3UBWyEd7AgLzmSL6Y3VBF+jmCS67bfxl2u7W/XqXAX0k2m1N6LOg7l/Hzh0AIY8q
         Lyiw==
X-Forwarded-Encrypted: i=1; AKwUvBx/ZcQLkbrtr2mxNibkpUt8ckGDlcE7ndW8zVUhesbzEu8Ik2VAJT5yW2WGiSvTU8M3Uf8bZQjszcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqywdYcrJkf2jzrhcs7WOuhvNRQbCgR46HPNRx0g2lj6C6ZnPC
	Ki+lnenIfczRXCPk9micaqRxntLbug2Tme+TbZwuam7bkEn43ZJSglVH
X-Gm-Gg: AYBFou3vSnxaJElmeiZlugamrIdi9CwO80/ygEIgHcTtyu70GwgGUFFXP39YcRbSS5u
	uHYZGpB8h6jFWhDJwGygh6LYgM7TZ2yUOzthoflBiFXCfjS0eijZFZ3SEH3e1yMVS+e4+Q6GUHW
	1Mdfv3Z9GRgVUL3rcmnoervIYNd5d2A5zyymaA7krUwUJWr2YlRkOllMvUpuGt8r/DcGbWuL0N3
	FYIGFiK3d2Gji+iLuTiS6IkTxQV1zCQBQPMv/q0E2fUeapHR8msNm+NDsPqLMHWT5j8H9HXJueQ
	VG0rD36MVk+3k98ou7IV0T3p+YAevUBgci1Xe7e8/7Xl0KSRtwp1U4foKO/FAGRY0IT/+rE4ZLS
	w9ne4LYJdWpYmnCjT0JEAAnU/ulWepg5WoSv1KTM9sud4SrvKeu1db8GujEQ8UrUBianUtJPcgs
	mB3igQh5twfNqlpByq9kpQE+r1rkP3K9i0USh48d7CAALeQffQlLdZwtyQ8sEBXEzUGYXR4N3dy
	DwQddQa7SutRPlwlQLf
X-Received: by 2002:a05:6000:dd1:b0:487:13a9:80d with SMTP id ffacd0b85a97d-48dbaae342fmr27653662f8f.10.1792009501573;
        Wed, 14 Oct 2026 13:25:01 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm14448527f8f.28.2026.10.14.13.25.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Oct 2026 13:25:01 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:24:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu
 <ricky_wu@realtek.com>, Lee Jones <lee@kernel.org>, Roger Tseng
 <rogerable@realtek.com>, Dan Carpenter <error27@gmail.com>, Jisheng Zhang
 <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime
 autosuspend
Message-ID: <20261014222455.10595a68.michal.pecio@gmail.com>
In-Reply-To: <CABtds-1kHYrA_RtTtUh0jmx7jC6=08vDce5pREWhtv_cxGAgAA@mail.gmail.com>
References: <cover.1783352430.git.sean@starlabs.systems>
	<7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
	<20261005103011.03175826.michal.pecio@gmail.com>
	<CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
	<20261013142737.7b10a5b0.michal.pecio@gmail.com>
	<CABtds-0s8Co-qWk0xm=R1pdz3JyV_GyaiwYzgxS9g2tFwtHRzg@mail.gmail.com>
	<20261013143836.76ad7bf4.michal.pecio@gmail.com>
	<CABtds-1kHYrA_RtTtUh0jmx7jC6=08vDce5pREWhtv_cxGAgAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 14:48:54 +0100, Sean Rhodes wrote:
> > For the record, I have no issues with wakeup on insertion when the
> > reader is suspend.  
> 
> I do, but only on Meteor Lake

Sounds like an unrelated USB bug.

> >  The problem is when it goes to suspend with a card already
> > inserted and doesn't wake.  
> 
> I can't replicate this at all; my "bunch" are all fine (glk through
> arl, and cezanne through phoenix)

Host shouldn't matter in principle. Reproduction is simple:

echo 'module usbcore +p' >/proc/dynamic_debug/control
# remove the card
# in less than one second, this appears

[38244.954611] usb 10-1: kworker/0:0 timed out or killed on ep2in len=0/8
[38244.956547] mmc0: card 0260 removed

# MMC host is suspended and polling stops
# for two seconds, card insertion will go unnoticed
# the reader enters suspend with a card inserted

[38247.021374] usb 10-1: usb auto-suspend, wakeup 1

# removing the card wakes it up

[38250.163400] hub 10-0:1.0: state 7 ports 4 chg 0000 evt 0002
[38250.174416] usb 10-1: usb wakeup-resume

Regards,
Michal
