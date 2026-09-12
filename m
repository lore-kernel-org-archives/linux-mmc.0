Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5A471D1E
	for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228264; cv=none; b=TE4YYK4ey9lLDeV6AXhgg7Lplh6GspO3wCexwOV/h9tsynHa4s32UcxuNV5dFKZGq95pRK+gipQt29HBNwU+8/CM/bX4XS83/Si9tW7vsm7a84NCjWOFkVmgf3wUSVAnAcuJ9rLeLSsUE6unVb4QVZ1aJJNHyzh1KGzEYjx/yhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228264; c=relaxed/simple;
	bh=jYjhr9lQehwgsoB55McaT2/qQLnqXw43VwwgAETPBqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4XsJL6XifoDPA9CX8HV+XZtpwRIzI2jR6OAG0V8Wq+jV6PoWPV0cievS0AioTnjd2pwhJGUYNpQ8fH9GJnzTO7FvAAvxF2nQqX9YjtSHpb3692x32KZLJMiYedvk/OufL2HeW4feIrf59gfqCvL64pNIs9rQBGvgJJxwbeoYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=B5Z+lMD3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="B5Z+lMD3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso4105045e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789228260; x=1789833060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYsEok5/6RpeOa0+UdPPhWNeU1Av3CpfKIsBFwLi6qQ=;
        b=B5Z+lMD3RMMj7NVb/nfYAe9DpW00iaTkHgayOvY05B8q+8RkWJk6fAJAFkb72iwiyJ
         O0loOWoDYolpvpWZ5rVs4/SMg/Hz8YlSiFAsBG050eftDr4RIAPy7rizLvbYtovn9VCt
         bTGVVGCEq9a9FBCXkMQpCMeTXNmsJRuonxg8zcxKzn1lOpAxlhanYHYOks4Edg4VnJ3r
         lMJ6JlJyjpGetWqBo0FiaciOd3HPSKCLtxZvR6XrXercqClTkajUAvcu/sQRUq8JRPHg
         56uZDjTmeeoO38w5PIPxUFX1f+AwvlGvySbq2/PCPeeEJuqXqURiupMHDE6d7SRoV3ff
         uDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789228260; x=1789833060;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYsEok5/6RpeOa0+UdPPhWNeU1Av3CpfKIsBFwLi6qQ=;
        b=VRRBNId1FawIvc3cNYpxuU7dsf4hn5x6ZTsC2sPmuiI/Muy9GwjiCE03MScn20uNse
         y+ZOn3ZTA9/S3NkJcBH/0CxzVQaUDbrp3SruwxNLGi0IblGdcoF5U1+kRibbj1AOru8l
         RlQjW7M878mUQosqkY2fY00TTqEdOSLgRnXPTmoCkLqyr3SKeYgRgdW8sgfLaYdWxTaS
         zYmQnAR3WBNJL1+szZG55NX+bFNAT36UdrcUR7yR2DCGlBuS84mEk6LPpQ7kZtcN/Wp+
         Yjm2Rsng99e7si51j4YLm7sZan8MaDntZsPa7u5/2Om4AxqRMi5V9QE/UE3ZqDGwhn51
         02ww==
X-Forwarded-Encrypted: i=1; AKwUvBy+xGsuJB1o0+duqZl8ckiEeN1fNmGzlVMfjrpqD0991JfEnLZ8yRAVDMxnCjdkwvturFg0Mb0sbkI=@vger.kernel.org
X-Gm-Message-State: AFuF++lVIxz836oRxl27Xr7/ExQen9zy6lL+0IbQIjYiFIWP/olvEs6t
	lxINKj5gfw/Dz4dWgQcWHA75LP07TOWCK0LwUz3SHj/xIwHGtZr9xjUhNtngh4L0+bQ=
X-Gm-Gg: AYBFou0G8wuEkn8sS6Ub+v55PLD//h+VUGUfXYpnUJXd0u+1ao6m2ObvrsQ1+OBUmSZ
	mCSXxVH6sh+T/j9aBJUBOmIv6q1CWa8Qg8mUdRPMXqkdkC7XN1FsR4Wkx98ZnbF2uOgrPHtNkWn
	DUM+bqzzzG1lIIXEM/Qx4JVVZCsbowm3H9nQiz72VPqZ1rb34eTvMzSAwWHC83Jk1+GKqg2dmD9
	1GU7BX7kU5LhPpcc8/7jA8Yu3l20unrj54l3qOPgB1EqsArKCe/3Oy4z3Zdfg7xVVdd7uKGC9T3
	ELp+05ZCeT5ouF/QVvuWSDBcXfqdxMEThAYyNm7u1x/xGMndNYlEUr/VZqEpzqvgSIOnp6LbR3f
	eW5vKAvScWg00lONqvDIUzpO45SWmeJvznHyNceGGL3f1rfrzZ2NPriQGgbfYEma7YR9vZWs7BM
	pIM1fDkKhIfe8CgNGDhpjpmuwzVcjNPQOf6Hpsv5xhRvbEEUbS3qqFm2WAvpq6NtKHXrKv8Xx55
	nVrZHrt5a3DD1HzCJoMaeA3hsdh
X-Received: by 2002:a05:600c:8b8b:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-49e6cbfeee9mr26096875e9.20.1789228260689;
        Sat, 12 Sep 2026 08:51:00 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e636f7fa2sm154001915e9.15.2026.09.12.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 08:51:00 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: tanure@linux.com, Brian Masney <bmasney@redhat.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>, Chuan Liu <chuan.liu@amlogic.com>,
 Jian Hu <jian.hu@amlogic.com>, Ronald Claveau <linux-kernel-dev@aliel.fr>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: meson: t7: don't mark sys_ampipe_nand as
 critical
In-Reply-To: <CAJX_Q+2vpcFw-5evCkykwWo6jbHvKvQ4XjYt_EKFyJuQm_ES5g@mail.gmail.com>
References: <20260905153234.133217-1-tanure@linux.com>
 <20260905153234.133217-5-tanure@linux.com> <aqSX-kUvYaixESxe@redhat.com>
 <CAJX_Q+2vpcFw-5evCkykwWo6jbHvKvQ4XjYt_EKFyJuQm_ES5g@mail.gmail.com>
Date: Sat, 12 Sep 2026 17:50:55 +0200
Message-ID: <1jcxui79k0.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On sam. 12 sept. 2026 at 08:50, Lucas Tanure <tanure@linux.com> wrote:

> On Sat, Sep 12, 2026 at 1:08=E2=80=AFAM Brian Masney <bmasney@redhat.com>=
 wrote:
>>
>> Hi Lucas,
>>
>> On Sat, Sep 05, 2026 at 04:32:34PM +0100, Lucas Tanure wrote:
>> > sys_ampipe_nand clocks the pipeline stage inserted in the bus path
>> > between the SD/eMMC controllers and the NIC_MATRIX fabric. It does have
>> > identifiable consumers - the three MMC controllers - so marking it
>> > critical was the wrong tool: the clock should be referenced from the
>> > consumer nodes and claimed by the mmc driver instead.
>> >
>> > Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
>> > sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself and
>> > have no single identifiable consumer.
>> >
>> > Assisted-by: Claude:claude-fable-5
>> > Signed-off-by: Lucas Tanure <tanure@linux.com>
>> > ---
>> > This patch depends on the MMC controllers actually referencing the clo=
ck:
>> > the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
>> > clock must land before this patch, otherwise the boot hangs and memory
>> > corruption this clock caused are reintroduced.
>>
>> This series should be merged together in one tree? Which tree? I can
>> provide an Acked-by if it should go through the mmc tree.
>>
>> Brian
>>
> It's definitely best to keep the series together in one tree to avoid
> boot regressions,
> but I think the clk tree is the better fit since the core changes
> revolve around clock logic.
> Could you accept it ?

No. This applies on top of another change already queued in the amlogic
clock tree. It can't go through the MMC tree at the moment.

This clock is not critical in mainline right now, so
1) I could merge this and it and in practice there would be no
   regression. The problem you had would still be there until the MMC
   change lands

2) Or you can wait for the MMC stuff to land and re-submit this in
   the next cycle.

Your choice. IMO, (1) is fine.

>
> thanks
> lucas

--=20
Jerome
