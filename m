Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647253;
	b=KlrHVFBcC5cNQGK48Yxph1ztB8BE1KI37gRBEQb11VrokFGd6sjutT3LsmjmoGWOkZHe
	 G+7iCAYd8lXQOyqNc61Z2vA4fTUAelB9jcy0pN2dLNq268aWHJAkmVRvxZCDR5PDhTexN
	 oU9Kh1uzexCMoA/5KkHCQf/Oadw2Kj0Y73ExeVC3MvZshyTOitiVqVOuiSauIWgkOVBro
	 Dz3oNcLyJUOMPPK2QMNrMQmi39CumTPaGi7n59jsHYN5oY64Csg7+ZBzrzat9PLHgMVDi
	 bpr16c5EpVIaPQKh1mHguxgsOixSPnZTIRRArdH7zWLG/O51bDITbEl/FW2DL7NW/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647253;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=ds0gPqcUBP6L02Z/8E2crybbPUoGn59iBftHI08WL+0=;
	b=i1HApVAStE/fheYitrmUwA05i7/aTbmAjp8T7cq+br38WiIeC3grNTBe67vS74JpFuqD
	 Xr9nMlJHQAbPjedZge10T/rqYU9h1QNKgJ942u5l1a4hSCRfgKr3zVNip209HfaKF+bbd
	 JqFcSgZfyhwaMxV7dZngbrZthVYrSG0WWy7FsgWqpMjKOZ9vfbw3j+en4yIpg/Qsu+72E
	 hm80BVr8gU/4LupN2vG/7XLF0SXyd8lO9Ujt+rx2T4IJ0fkvI0nKX2iNtyUBl6fxASU+t
	 4DGDczLTrEiCxyb1JkTNf/vj4ajJ8ubORGaaMps9pwbeXyRScwP6dhDZtSBLZPJzM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=h+FwYlqT;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBE606A31B;
	Thu, 22 Oct 2026 05:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99BBE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=h+FwYlqT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792647243; bh=ds0gPqcUBP6L02Z/8E2crybbPUoGn59iBftHI08WL+0=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=h+FwYlqTXgik5If3mRRsEVYopsIgtFSMYaP28ZusSHv97d6QMxi1q5+lQrRojqo0i
	 Lote634BZGuOddK1Yxmt+rdrq/5kMqIyam1vRK9bNh1qz3LJ8OjX9Hv0UgBUK8K15t
	 LnvekWnyUNS0m+DYfJrDJbnbnXX5pkEqcGkf7r8A=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: MhG7PnEq6uVZHX1/fLwaNH4gNTfoyBXS9ICP9bBvYMJm10JGRqKmUPNfnZovbK
	 nS7LD3DnZM7PG6RiQaSUv5jA6wcYID4CXviFq5wgLYtO/p9oKsmGavyZL23IQr7d0d0757wXjmQq7
	 yQ7P4DlSJst9LAB48rnkgVe6bMMGzgnOMnx2w510aEb7WmMOZugA+FKA7dFvUSF3uk29l84MQCVWa
	 jQFL/6ymo+L5sPEnKeO+fuYDDV04n5JfOPyZEFeAEmfXWUAB8OTy/p4ZQ0lksVvz66JR0MwPQoyDb
	 n5LAxPqjoQkDSVYojlFvKE3QRWo8Nw4pbcgx4sO7HHLYRRdk9PdPe1dl9Oz8L3gwwLZpO2vxs5hei
	 qATp4aaTQFXj3yXC1oG+ha4AW+3PduUTMWV52PMWa7MyzJ6vjj4gJqIyME5EoA42vB0JgxZ7NY2Wo
	 9myLFVs1KHj6pNKchD7+yXWnERL3VjkJvvBiZMlLb+FmlEJNA1LZYvJvP7REb9kMKka3Qc/kMWdpw
	 ME+RFtbLfk9lZ3u5hhUqIRHqnTf9HAtOaX3qkfGVxMghLWghcRkCcjp4YduvxdIgqa1UNak48VkSA
	 TlF32t4i+7UTKw6wipXCWXomB5M6/VJB6cp/POqY8gU7URPIvvU4LD0ukvML2czWLuGUYH6r30P/m
	 bXX6boLd8ugiSZw7/nbZ+RGDcnBecAq+r9/slaKApRUKH7s6zm7GotVwmdnJX9S+l+rdESnP8wViE
	 9vbJL80OFI3AlQqnZEpKIeUtv1OELzKLi9bW/Ak0ZE/uS42Sx35Z7jFPP1A6vwGu63jbHjFK2hvdT
	 aBnJvGGAzxze/RxDGZcoRUCiglOCmYcbCRxQ+BkyuLIVrFgllCCVH4GP9So5GCpK4pC842+2Woz3H
	 /x0wBngA2q2A7jL3A4irwZ7fQe06KnNpbK6/KiHbsZ/CwDFMDYmJAPFfRA/yGUucc0EF5M1edwKPd
	 c8e3odi6IFHoUhzcHqXa1FRKkNwZNlZ1NgdSi1gSFjCRn53/lCjp4yXQ+W6Ng6LzXU9RbIkD7soUE
	 HaUAEHfrtNxYdCY9egQi/AEZt8oWCx2fFBPqR3sDpr3zBscPLFvJxBqm6q1PwCEUu0SMeN+rBHNVM
	 iuzehjqgE1gJVCUlbFuba+5M
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew@lunn.ch>
Cc: "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, "=?utf-8?B?QnJpYW4gTWFzbmV5?=" <bmasney+clk@redhat.com>, "=?utf-8?B?SmVyb21lIEJydW5ldA==?=" <jbrunet+clk@baylibre.com>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?UGhpbGlwcCBaYWJlbA==?=" <p.zabel@pengutronix.de>, "=?utf-8?B?RWxhaW5lIFpoYW5n?=" <zhangqing@rock-chips.com>, "=?utf-8?B?TGVlIEpvbmVz?=" <lee@kernel.org>, "=?utf-8?B?TGludXMgV2FsbGVpag==?=" <linusw@kernel.org>, "=?utf-8?B?QmFydG9zeiBHb2xhc3pld3NraQ==?=" <brgl@kernel.org>, "=?utf-8?B?UmljaGFyZCBDb2NocmFu?=" <richardcochran@gmail.com>, "=?utf-8?B?VWxmIEhhbnNzb24=?=" <ulfh@kernel.org>, 
	"=?utf-8?B?QW5kaSBTaHl0aQ==?=" <andi.shyti@kernel.org>, "=?utf-8?B?R3JlZyBLcm9haC1IYXJ0bWFu?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?SmlyaSBTbGFieQ==?=" <jirislaby@kernel.org>, "=?utf-8?B?SmlzaGVuZyBaaGFuZw==?=" <jszhang@kernel.org>, "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew+netdev@lunn.ch>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?RXJpYyBEdW1hemV0?=" <edumazet@kernel.org>, "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>, "=?utf-8?B?UGFvbG8gQWJlbmk=?=" <pabeni@redhat.com>, "=?utf-8?B?RGF2aWQgV3U=?=" <david.wu@rock-chips.com>, "=?utf-8?B?UmFmYWVsIEouIFd5c29ja2k=?=" <rafael@kernel.org>, "=?utf-8?B?RGFuaWVsIExlemNhbm8=?=" <daniel.lezcano@kernel.org>, "=?utf-8?B?WmhhbmcgUnVp?=" <rui.zhang@intel.com>, "=?utf-8?B?THVrYXN6IEx1YmE=?=" <lukasz.luba@arm.com>, 
	"=?utf-8?B?TWF4aW1lIENoZXZhbGxpZXI=?=" <maxime.chevallier@bootlin.com>, "=?utf-8?B?TWF4aW1lIENvcXVlbGlu?=" <mcoquelin.stm32@gmail.com>, "=?utf-8?B?QWxleGFuZHJlIFRvcmd1ZQ==?=" <alexandre.torgue@foss.st.com>, "=?utf-8?B?Vmlub2QgS291bA==?=" <vkoul@kernel.org>, "=?utf-8?B?TmVpbCBBcm1zdHJvbmc=?=" <neil.armstrong@linaro.org>, "=?utf-8?B?TWFuaXZhbm5hbiBTYWRoYXNpdmFt?=" <mani@kernel.org>, "=?utf-8?B?VGhpbmggTmd1eWVu?=" <Thinh.Nguyen@synopsys.com>, "=?utf-8?B?SmFlaG9vbiBDaHVuZw==?=" <jh80.chung@samsung.com>, "=?utf-8?B?U2hhd24gTGlu?=" <shawn.lin@rock-chips.com>, "=?utf-8?B?bGludXgtY2xr?=" <linux-clk@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bWZk?=" <mfd@lists.linux.dev>, "=?utf-8?B?bGludXgtZ3Bpbw==?=" <linux-gpio@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?bGludXgtaTJj?=" <linux-i2c@vger.kernel.org>, "=?utf-8?B?bGludXgtc2VyaWFs?=" <linux-serial@vger.kernel.org>, "=?utf-8?B?bGludXgtbW1j?=" <linux-mmc@vger.kernel.org>, "=?utf-8?B?bGludXgtc3RtMzI=?=" <linux-stm32@st-md-mailman.stormreply.com>, "=?utf-8?B?bGludXgtcGh5?=" <linux-phy@lists.infradead.org>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 16/27] net: stmmac: dwmac-rk: Add RK3572 support
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
Date: Thu, 22 Oct 2026 13:33:59 +0800
X-Priority: 3
Message-ID: <tencent_DC0344109BFDE09B646864649812CA465409@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>
	<b1ab0503-628c-4f96-af38-727d4be06f8a@lunn.ch>
In-Reply-To: <b1ab0503-628c-4f96-af38-727d4be06f8a@lunn.ch>
X-QQ-mid: xmsezb41-0t1792647239txf7q5rwo

SGkgQW5kcmV3LAoKPiBZb3UgbmVlZCB0byBzcGxpdCB0aGlzIHBhdGNoZXMgcGVyIHN1YnN5
c3RlbS4gUGxlYXNlIHNlbmQgYWxsCj4gbmV0d29ya2luZyBwYXRjaGVzIHRvIG5ldGRldiwg
b25jZSB0aGUgbWVyZ2Ugd2luZG93IGNsb3Nlcy4KPgo+IGh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYuaHRtbAoKVGhh
bmsgeW91IGZvciB0aGUgZ3VpZGFuY2UuIEkgYXBvbG9naXplIGZvciB0aGUgaW5jb252ZW5p
ZW5jZS4gSSdsbCBzcGxpdCB0aGUKc2VyaWVzIGJ5IHN1YnN5c3RlbSBhbmQgc2VuZCB0aGUg
UkszNTcyIEV0aGVybmV0IGJpbmRpbmcgYW5kIGR3bWFjLXJrIGRyaXZlcgpjaGFuZ2VzIHRv
Z2V0aGVyIGFzIGEgc2VwYXJhdGUgc2VyaWVzIHRvIG5ldGRldiBhZnRlciBOb3ZlbWJlciA5
LCAyMDI2LgoKQmVzdCByZWdhcmRzLApDdW5oYW8=

