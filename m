Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088859;
	b=pQGcqSKILnk8gTXOwhaT8OPlZHlAGS/ExAisYy1frGA5KpWtltaIEHrKtL7/6atLG8yu
	 PZqcT7JqC3x6eqstTj3GcQX7B/6iJjZjiXzh8csVX7Deq2SpE34Tb1jVa6tIB8hQCgeb9
	 3SVVD/+uvBiRlOwKyHwUkAyYhuwXseTGrpCoqYQCpGHzruWUq5I9ExsqypevhcFjnqehr
	 vqOEG+Ts+OzPnNo7hLxB7qOacchY8iWXMR2EI9GnPyBGw2545HN7lNixJ/83XvDNqGZDk
	 +P6HZRVQDSg5kzFFv6IW6cmNWWJbv8Jk0f/T5oVWYcY+DPEqoMDoy1hmQLYCAWE93BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088859;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=nGbu4upuJLgm2lXKD/Z91nFxrjKCKZHpwQrOt6s2bDY=;
	b=T9P0YceJrHewQNWUI7QxqijjRYwa3mnclkDrnrzLY85NHp9HxmjnXoKLjUSnfsoZhhu5
	 yKEZ5kfnIBG6JR3sqSkIbfnT/mf0pO7uarCVGuzjJYofGvWwYx9GSKpo8EzJIpFQNmIpg
	 /by7FLwuQosjOdNJR42X8xKJbe9/bx4Hb4bn6ZIiu9oZztvaIkbesHUkSwYQJLB6zRIkE
	 lX7mhoJI5fae/aFRg6ccu8cWLk+Zgo8xlY1/s28qU35A3VGdjgspZXgWj0nF3mR/rd7HT
	 yEQt1kN36a/p4kCkqCNxoN5A2MER7/UmcxlwQ2+ciEpFkOBLrOu6cLaVyzu6u2QcDCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZRB1vNch;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47E606A339;
	Tue, 27 Oct 2026 08:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D47E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZRB1vNch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793088845; bh=nGbu4upuJLgm2lXKD/Z91nFxrjKCKZHpwQrOt6s2bDY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=ZRB1vNchEBn1xTDidt7KlotYbtlRGWLoegdUkgm34YutKGqGFS1vndGuabXwuQZ90
	 /f0QxD6nmcPMBlMpQq6BxhjlE6opBg1xCkYHbn2pqTPsi40cCO5nyYQN/e07PWbv1P
	 526lVXWyA9AKXODNJhPhJr8lZw09DmYOIJjw38go=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: M/8oWtQ8RXooJTRnGxFYe36RnPXjfz6V34oARLY5ztdCgTVzwe4zrpt0OZIqiV
	 6WOy1tfKUMOwIp89CO5v2jtf8fTEeOq5mi2JUzH4Nef7OjAKvx4xPiylH90reQ6IHIXTUg6D63e0T
	 481ZvsLL6TnnEWH6cGafWPYXdPkOaWIDYmQaR1TyCkbo1JAipqPJjLWdkJ7c5f9Ntm6rE/Vc85MFA
	 6/0Yv3GuE058KwOnH34QUKfrzxTwP4bBI/d4wotgx7yzEXWjSCUkxlS5SsVZOnxqFUStijqTic+NF
	 aNvSUUJDUS18HxXkxELs9NR1BNaF9SEdq07pweT3dgStQMYxIOxFwsx6Ap79t3P7Wda50cBNlyUzK
	 L0nGZYeXMmxra3ro1YB2pEadf81VxEf50WmhVY2f7ZPN8y/UM4PdbyPXVRvhxVv5nxNg2J/hfK3Kw
	 pSUJyHx1xsdjaUc/Gnio/6cqfs97icdTwq6NCBZO/byU2hnjUaTaSt9AEwM87gAki9zbOe1yZScN+
	 PYFSmvDn44vv/ex5eNUA78ks2mSVtzQxrO7o6vvSIaJ6tqOmxNsMswoV+th2FwjbUQUCw5dIurGYx
	 UiC98zYj+8M80tQd0v5a55xNOCWrzJMcpL9u6ctYYBOGjDYnmGgQj5BgHu3DucOOtbhhIP6iVdcse
	 NZTX916vUU0yg5PAavrQyQmT52VA/r5Xy6Ozbu+A1EzoVqgRPIIiO+pX5cRNy8l9R/uK/vKiFdjfS
	 Ky3dE5tvMSNS1KhWn0R+OuSWPkiRCjFJy5irVQouqZ4/77IVsPighdskAl4O9q7fgA02C+iRFllws
	 TrKDgHhDDjWkiTzDvbHNZ+Xui1Lnl5aLZBJ/0ZBY97G6jebO3CJGueOksuo4EaO36eMoHjNsEs7jF
	 gP2WMOd83oGx+87D1EJrlBu4GKZGwED07/KKJKyeCzvvIAfQ9zrQH9ERkrMRJD8C0oXuiXNt8am21
	 KQeoVpouoyLgDKb99Ev+/BEPpEcXH07BurkkWIUVwhaRz5pdTGd6RB/IhJuRgQajP6VGsNTm4Hw8p
	 61dj2p8TsB+wovP+gd5bvf5tjSyip3s4Xa6VnLxgzG1xCV2ekXBbBh4XrhkKmA+tZOsI4QpyF03f0
	 IPelgJyNvew7LQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?U2hhd24gTGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?TGVlIEpvbmVz?=" <lee@kernel.org>, "=?utf-8?B?TGludXMgV2FsbGVpag==?=" <linusw@kernel.org>, "=?utf-8?B?QmFydG9zeiBHb2xhc3pld3NraQ==?=" <brgl@kernel.org>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>, 
	"=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulfh@kernel.org>, "=?utf-8?B?QW5kaSBTaHl0aQ==?=" <andi.shyti@kernel.org>, "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?SmlzaGVuZyBaaGFuZw==?=" <jszhang@kernel.org>, "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew+netdev@lunn.ch>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?RXJpYyBEdW1hemV0?=" <edumazet@kernel.org>, "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>, "=?utf-8?B?UGFvbG8gQWJlbmk=?=" <pabeni@redhat.com>, "=?utf-8?B?RGF2aWQgV3U=?=" <david.wu@rock-chips.com>, "=?utf-8?B?UmFmYWVsIEouIFd5c29ja2k=?=" <rafael@kernel.org>, "=?utf-8?B?RGFuaWVsIExlemNhbm8=?=" <daniel.lezcano@kernel.org>, "=?utf-8?B?WmhhbmcgUnVp?=" <rui.zhang@intel.com>, 
	"=?utf-8?B?THVrYXN6IEx1YmE=?=" <lukasz.luba@arm.com>, "=?utf-8?B?TWF4aW1lIENoZXZhbGxpZXI=?=" <maxime.chevallier@bootlin.com>, "=?utf-8?B?TWF4aW1lIENvcXVlbGlu?=" <mcoquelin.stm32@gmail.com>, "=?utf-8?B?QWxleGFuZHJlIFRvcmd1ZQ==?=" <alexandre.torgue@foss.st.com>, "=?utf-8?B?Vmlub2QgS291bA==?=" <vkoul@kernel.org>, "=?utf-8?B?TmVpbCBBcm1zdHJvbmc=?=" <neil.armstrong@linaro.org>, "=?utf-8?B?TWFuaXZhbm5hbiBTYWRoYXNpdmFt?=" <mani@kernel.org>, "=?utf-8?B?VGhpbmggTmd1eWVu?=" <Thinh.Nguyen@synopsys.com>, "=?utf-8?B?SmFlaG9vbiBDaHVuZw==?=" <jh80.chung@samsung.com>
Cc: "=?utf-8?B?c2hhd24ubGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bWZk?=" <mfd@lists.linux.dev>, "=?utf-8?B?bGludXgtZ3Bpbw==?=" <linux-gpio@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?bGludXgtaTJj?=" <linux-i2c@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?bGludXgtbW1j?=" <linux-mmc@vger.kernel.org>, 
	"=?utf-8?B?bGludXgtc3RtMzI=?=" <linux-stm32@st-md-mailman.stormreply.com>, "=?utf-8?B?bGludXgtcGh5?=" <linux-phy@lists.infradead.org>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 24/27] mmc: dw_mmc-rockchip: Keep RK3572 NVM domain powered
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 27 Oct 2026 16:14:00 +0800
X-Priority: 3
Message-ID: <tencent_0431D34CCA9424908F2C068820D6F9C1370A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-24-0b0fd85a31ee@qq.com>
	<bb38e2c8-1868-4a66-9e0d-78d9f68ab4be@rock-chips.com>
In-Reply-To: <bb38e2c8-1868-4a66-9e0d-78d9f68ab4be@rock-chips.com>
X-QQ-mid: xmsezb41-0t1793088840t5jwsbqnj

SGkgU2hhd24sCgo+IEJlZm9yZSB5b3VyIHYyIGFib3V0IHRoaXMgcGF0aCwgSSB3b3VsZCBs
aWtlIHRvIGFzayB3aHkgeW91IG5lZWQgdGhpcz8KPiBUaGUgZHdfbW1jLXJvY2tjaGlwIGNv
bnRyb2xsZXIgaXMgYWx3YXlzIHVuZGVyIEEgcG93ZXIgZG9tYWluIG9uIGV2ZXJ5Cj4gU29D
LCBub25lIG9mIHRoZSBwcmVkZWNlc3NvcnMgbmVlZCB0aGlzIGtpbmQgb2YgY2hhbmdlLiBJ
ZiB5b3Ugc2VlCj4gc29tZSBlcnJvcnMgZHVyaW5nIFJQTSwgcGVyaGFwcyB5b3Ugc2hvdWxk
IGhhdmUgYSBsb29rWzFdIGFuZCBjaGVjayB5b3VyCj4gRFRTLgoKVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgcG9pbnRpbmcgb3V0IG15IG1pc3Rha2UuCgpJIHdyb3RlIHRoaXMgcGF0Y2gg
YWZ0ZXIgb2JzZXJ2aW5nIHJlcGVhdGVkIFNEIGNhcmQgcmVzZXRzIGFuZCByZWNvdmVyeS4K
QWZ0ZXIgc2V2ZXJhbCB0ZXN0cywgSSBmb3VuZCB0aGF0IGtlZXBpbmcgTlZNMSBwb3dlcmVk
IHByZXZlbnRlZCB0aGUKcHJvYmxlbS4gSSBjaGVja2VkIHRoZSBTRCBzdXBwbHkgYW5kIHBp
biBzZXR0aW5ncyBhZ2FpbnN0IEZvcmxpbngncwp2ZW5kb3IgRFRTLiBUaGUgc2V0dGluZ3Mg
bWF0Y2hlZC4KCkkgdGhlbiBzZWFyY2hlZCB0aGUgbWFpbmxpbmUgaGlzdG9yeSBmb3IgUksz
NTc2IGFuZCBmb3VuZCBpdHMgU0RIQ0kKd29ya2Fyb3VuZCB0aGF0IGtlZXBzIFBEX05WTSBw
b3dlcmVkLiBJIHRoZXJlZm9yZSBhc3N1bWVkIHRoaXMgd2FzIGEKc2hhcmVkIGRlc2lnbiBp
c3N1ZSBpbiB0aGUgUkszNTd4IGZhbWlseS4KCkFmdGVyIHlvdXIgZW1haWwsIEkgY2FyZWZ1
bGx5IHJldmlld2VkIGFuZCBjb21wYXJlZCB0aGUgRm9ybGlueApPSzM1NzItQyBzY2hlbWF0
aWMgYW5kIERUUy4KClRoZSBPSzM1NzItQ19MaW51eDYuMTIuNThfQWxwaGExIEJTUCBpbmNv
cnJlY3RseSByZWZlcmVuY2VzIFJLODA2IFBMRE80CmFzIHRoZSBTRCBjYXJkIHN1cHBseS4g
VGhlIGNhcmQgYWN0dWFsbHkgdXNlcyBhIHNlcGFyYXRlIDMuMyBWIHN1cHBseQp0aHJvdWdo
IGEgc3dpdGNoIGNvbnRyb2xsZWQgYnkgR1BJTzBfQjYuIFRoZSBvcmlnaW5hbCBEVFMgdXNl
cyBuYXRpdmUKUFdSRU4sIHdoaWNoIGxvc2VzIHRoZSBlbmFibGUgc3RhdGUgd2hlbiBOVk0x
IHBvd2VycyBkb3duLgoKSSBpbmNvcnJlY3RseSBhc3N1bWVkIHRoYXQgRm9ybGlueCBoYWQg
dmFsaWRhdGVkIGl0cyB2ZW5kb3Iga2VybmVsCmFuZCB0aGUgY29ycmVzcG9uZGluZyBkZXZp
Y2UgdHJlZS4KSSBhbSB2ZXJ5IHNvcnJ5IGZvciB0aGlzIGluY29ycmVjdCBhc3N1bXB0aW9u
LgoKSSB3aWxsIHJlcG9ydCB0aGlzIGlzc3VlIHRvIEZvcmxpbnggYW5kIHJlcGxhY2UgdGhp
cyBwYXRjaCB3aXRoIHRoZSBEVFMKZml4IGluIHRoZSBuZXh0IHJldmlzaW9uLgoKQmVzdCBy
ZWdhcmRzLApDdW5oYW8K

