Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC73C3420;
	Mon,  6 Jul 2026 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378510; cv=none; b=nGcr69MUMEI89HzeINLlNMQ8qbptIrBRwpayMB8KdY+iegK4szdrBLZXoGYxKDJh41e4t8sdQ58Pc3yPVZoayK7bA5ShWYHq0v6KGOB0mW6svLKwX9KCRrokh1qXh8l8ldaTjeTl6buKb6loMgPuM02C2MacoLk5tzALw3U4OXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378510; c=relaxed/simple;
	bh=yqOChaSZ5mNzOHjnrSQyl4fbvGS4SDgoUW14pbM5IrM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=bNaCe7syKL6fourLeVGMCSxYftoiZk3gIj7Trjw0f8n5tLcOm2a24jBB0EMQQQi8w43ErkLx/NZpw7I/zQBitgU/TmDg8lTTu3vhjSB3gRpRELOjov2ypjqOhdp+omVHYGNdjJi74zbJnW0HW3o1ZaRQkvHVr+65YtdP8spV+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=N91q2DVr; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="N91q2DVr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id A6517118E9C;
	Tue,  7 Jul 2026 00:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783378498;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yqOChaSZ5mNzOHjnrSQyl4fbvGS4SDgoUW14pbM5IrM=;
	b=N91q2DVrLhVhaY1zfNR7RwfRtnj3hnyquGke4MS17FCPbX3MDC1NPENUl8gIPyS2ir68pu
	GgskTiNDkSOU27umVmvh3sZgOXjWOx1S1qcfhEiRprC5tTBDEQSeFcTyhg6OtcfSl5QDRP
	Y6AGozqKXTV7SaaJczcFbneu9i/QrAdQFcAbz5op3wzvCwJT/XH5RlKYa1czGLbFVMy3ee
	DHQQxdb1eohVsJrjMn378/bsPNcLIlf67fbMyk+Fj3GEiS6Mr+j1lR1ecsJHZxwtWi35ki
	h7faeL/UF1XN6SEw23+jcYlADtsCJUr6m+9XvMHkc3AAGqYzp9zRmfsjZ0CUGw==
From: "Fabio Estevam" <festevam@nabladev.com>
In-Reply-To: <20260706195818.3906949-1-sjg@chromium.org>
Content-Type: text/plain; charset="utf-8"
References: <20260706195818.3906949-1-sjg@chromium.org>
Date: Tue, 07 Jul 2026 00:54:44 +0200
Cc: "Heiko Stuebner" <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Albert Aribaud" <albert.u.boot@aribaud.net>, "Andy Shevchenko" <andy@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Brian Masney" <bmasney@redhat.com>, "Chukun Pan" <amadeus@jmu.edu.cn>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>, "FUKAUMI Naoki" <naoki@radxa.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guenter Roeck" <linux@roeck-us.net>, "Jamie Iles" <jamie@jamieiles.com>, "Jeffy Chen" <jeffy.chen@rock-chips.com>, "Jiri Slaby" <jirislaby@kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>, "Jonathan Cameron" <jic23@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Michael Opdenacker" <michael.opdenacker@rootcommit.com>, "Michael Riesch" <michael.riesch@collabora.com>, "Michael Turquette" <mturquette@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Rob Herring" <robh@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Ulf Hansson" <ulfh@kernel.org>, "Wim Van Sebroeck" <wim@linux-watchdog.org>, "Yao Zi" <ziyao@disroot.org>, "huang lin" <hl@rock-chips.com>, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
To: "Simon Glass" <sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <882555c4-e1a3-0a0a-6830-b824b93cf3ac@nabladev.com>
Subject: =?utf-8?q?Re=3A?= [PATCH 00/12] Add support for the Rockchip RV1106 and 
 RV1103
User-Agent: SOGoMail 5.12.8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hi Simon,

On Monday, July 06, 2026 16:57 -03, Simon Glass <sjg@chromium.org> wrot=
e:

> The series follows the structure of the recently merged RV1103B
> support. The clock driver is ported from the vendor kernel and is the

When I submitted the initial version of the RV1103B series, I received =
feedback to split it into subsystems.=20

You should do the same here and submit it per subsystem:
ARM, clock, pinctrl, serial, mmc, watchdog, and iio.

