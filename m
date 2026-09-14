Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0326472527
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394214; cv=none; b=OeCbS2AkyCAVNyJJ0Qt+CL/GjS99ldl27gSb+Ug+ze/N26IXhjruVQXIgsrS9L6/nvN/W6Oo7z9VPsvvCIMMwsWNUnuakMlvCPCKsHdaUW0MdK122lbmcvGPQoTEJdyeiE/sS8zImyYe3hZ/cqMhVqVbwMwGeeZmmCP2E/9cIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394214; c=relaxed/simple;
	bh=jTXdhOWHb+tc8C306czNkIrV9+xG+lE9QUA2R7XrZmw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=Kjkfm7wFI3tqVjPL57B9uPz7QwjZUovPKk4ZbvmJLfvgTbd0gbX7Vr4glTxlyBLDbpqYYMuUPLjXzi8xNDlDtvL+rZbkBBBy4/C6HBj/ubV7DfCSDX/66gDJGapkXBvD/SnVaeuC4xaDnHlis5RpysQwjA3uiVtWFDV8eRdM/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kko+DJ26; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kko+DJ26"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1245329a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394212; x=1789999012; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czQcbmKAQjpPrrgr487KiVX0zj39eEVICUIzqR7EEkY=;
        b=kko+DJ26ujlfKwfe3QrU7w9Eq62zp0WlHMn2i3D7DIOrMLyO702mhZCDPt/0oGgCtL
         V0cLwOc9zewDYvYkmyZ/8igXHHi2dtqyk6ttyNeCvZNU+PgxP/BFxqCaH+nPUlkfdBvy
         HlUuP0wPypTZOlPYXqH2ikjbXdOIw50KVugsiJHXeMFuNFKtJk4QQIqqOaHKC9tvhjMH
         Bbl70JCPIfcocT1/jWmaxKp/KurfOxThLWp4gh7GqZ5U06DGBo0Np8r2UOdxEmLLhO49
         ETh9Nw3X3zZ4GGpnBDGY5or4bzXdm9CC8OUHAKLsvQUdaJmj5+XrPqoGjaD6dSmxINp2
         n0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394212; x=1789999012;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czQcbmKAQjpPrrgr487KiVX0zj39eEVICUIzqR7EEkY=;
        b=M7Iqs1SOYzeEobNdShAFPTxU2hNbNyQz2vzsP7CriOC8lTnEAcKrAGLXpmhy3jdbZq
         ONYtzeVQtOS9gclN+BtrHj+OWXj/Le0xgu39LGaZ5nb3gleX2wPAtnXD8QMJkSuR+byg
         /8pzJHUWcdUbYjArf61iAUBEyfc8CpfYswcdXkihH65uUYIPVlYa4WWm0FsTZArGMQTb
         Q+AM0Z1X6aj4xN+BY8wTGWhIHRAys5NxXbASkXU+kcIDWVB8ra+6Jyf+IejGxJvTfu2y
         8WTbwwQrR4Ufa2P+ZSElqlTv9+goAKx6qdNhOcCsc+U0ZnU+1bOoTIDb+8hgYjnmnhCv
         mqFA==
X-Gm-Message-State: AFuF++kHlp3L+Ehsp9Lvxg3lliN9PwK9Ug6M3go/xdn2XDCPyjd+QKn/
	47m1eS62v3aAX+qB2cLsxkT4A8J18baNWSYvlrz2gNkV0L+sY8qXLzO1
X-Gm-Gg: AYBFou1XvnaJfVJfa/HOja+KzZEaqX02QrXxIaEGMIz1Lh4bHed/9Nvq9Fiqk1Dm52B
	3nUXPfNIfMlyGWnmmXvjZkQsNgONoz4OTOaNbVxM6gU1w3Z0QwYW847LtIAJSKr6b20O8ZjnaaR
	OGoAlpSA616nEg6bzJqoYH0cYnVjnVq7yb/c54xYu75mHmL2eMJnosgJv64KkhSQoRAiheBae1z
	+x7SW8zKJOtf4aovwjRYdOaPsbdbCfwWFgWsl0NRdEmQcb9fpfV+CP4d3HBtKOMSha/CaZNRLmZ
	xU2fx7fuSpJ3FKvMl1qy0QzwbZvJilXScqKjLns26Bjd9oFX2FCvc1ofhCT2YkKRcnJuH8E3s6C
	AuA3bL9fm4lYUwc04vdI6UdTL3Y8nE3oKEnZzsy51j994/i1CRL3XXMLB69zNrp5l8fE4SgO16F
	/Wb5JqHI0yXNGuHSvFas0zkutAqKF1RSuw+25CP0nQvlAXpbVcih7R940fLYsSic1gHQZZJpv6Z
	g+Dnhnsslr28j1tw8kDW4V+zNvofoYJJ0L0CkoG
X-Received: by 2002:a17:90b:3c4b:b0:39d:f2a1:2f with SMTP id 98e67ed59e1d1-39df2a1040fmr3533075a91.17.1789394212037;
        Mon, 14 Sep 2026 06:56:52 -0700 (PDT)
Received: from localhost ([2401:7400:c804:63d1:a611:b433:d4e7:c402])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfb6ea4c4sm155391a91.0.2026.09.14.06.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 06:56:51 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 21:56:47 +0800
Message-Id: <DLF3B2I7WMSD.1VDVZ0BB6HE4H@gmail.com>
Subject: Re: [RFC PATCH] memstick: Add Broadcom BCM57765/BCM57785 host
 driver
From: "Ho Jie Feng" <hjf3108@gmail.com>
To: "Ulf Hansson" <ulf.hansson@oss.qualcomm.com>, "Ho Jie Feng"
 <hjf3108@gmail.com>
Cc: <linux-mmc@vger.kernel.org>, "Maxim Levitsky" <maximlevitsky@gmail.com>,
 "Alex Dubov" <oakad@yahoo.com>, "Ulf Hansson" <ulfh@kernel.org>,
 <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260912163810.848989-1-hjf3108@gmail.com>
 <CAPx+jO8MSY8P1R6ZbRF8C7Vb0zhmePhaDDzgi+BmC3uUdKqMfA@mail.gmail.com>
In-Reply-To: <CAPx+jO8MSY8P1R6ZbRF8C7Vb0zhmePhaDDzgi+BmC3uUdKqMfA@mail.gmail.com>

On Mon Sep 14, 2026 at 6:31 PM +08, Ulf Hansson wrote:
> On Sat, Sep 12, 2026 at 6:38=E2=80=AFPM Ho Jie Feng <hjf3108@gmail.com> w=
rote:
>>
>> Add support for the MemoryStick function of Broadcom BCM57765 and BCM577=
85
>> PCI card readers (14e4:16be).
>>
>> The driver is written by inspecting MMIO traces from the windows driver
>> and experimentally probing the device registers.
>>
>> It was found that the controller exposes an SDHCI-like interface with
>> TPC command handling. DMA mode was then inferred using the positions
>> of the bits in sdhci.h.
>>
>> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
>
> Wow! It's been a while since we received new drivers from memstick contro=
llers!
Yep I wrote this quite a while back and only go around to upstreaming it re=
cently.

>> +module_param(enable_dma, int, 0444);
>> +MODULE_PARM_DESC(enable_dma,
>> +                "Enable usage of the DMA (0 =3D no, 1 =3D yes, 2 =3D au=
to,default)");
>
> I assume this is useful because the DMA functionality is a bit flaky, no?
>
> In any case, I would rather not use a module parameter for this, can
> you please drop this. If needed at all, can we perhaps use a debugfs
> file instead to switch dynamically?
>

The traces from the Windows drivers doesn't use DMA at all, at least only t=
he nice
ones which call the kernel APIs to do MMIO operations, unlike some newer dr=
ivers which
do the MMIO within the driver. The machine doesn't have VT-d so that is not=
 usable.
Due to this, I inferred DMA operation from the bits from sdhci.h and doing =
some
experimentation on the device. The flag is only there because I may have mi=
ssed
something and the DMA path isn't reliable.

I will look into the debugfs stuff, thanks.

>> +
>> +static const struct pci_device_id bcm577x5_pci_id_tbl[] =3D {
>> +       {
>> +               PCI_VDEVICE(BROADCOM, 0x16be),
>> +       },
>> +       {},
>> +};
>
> [...]
>
>> +
>> +static int bcm577x5_reg_waitb(struct bcm577x5_device *dev, int address,=
 u8 mask,
>> +                             u8 value, int timeout)
>> +{
>> +       unsigned long wait_time =3D jiffies + msecs_to_jiffies(timeout);
>> +       u8 reg;
>> +
>> +       do {
>> +               reg =3D bcm577x5_reg_readb(dev, address);
>> +               if ((reg & mask) =3D=3D value)
>> +                       return 0;
>> +
>> +               cpu_relax();
>> +
>> +       } while (time_before(jiffies, wait_time));
>
> Please avoid the open coding and convert to the io polling helpers
> instead (iopoll.h).
Will fix in v2.
