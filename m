Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF517B402
	for <linux-mmc@vger.kernel.org>; Sat, 16 Nov 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771645; cv=none; b=SV72pBL3j4NIw8w9w/cXebALy4jHH7SVjaSb1EMkF0EpUwzCbinkU70/0ioezu3mGBgWg/AWfckLJaEMoNd1+1nkfULbG0OubrJf+k21GZQZSiRlhRygigft9CYs+ipG5pQcg+0FvqjqORJreR8WpcIzL0INmjrHjV0PPZ0Yd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771645; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=JLpLbR3W9J0zya9BkLji+JYmXWrcZ1ra2RNqJouONi3+eDRo0yhHsVxtgtM6YZKCcebgn6nZ6bwfjZNlvIjmb5mxM72ULILNe6IIbfu/MX9+EYXZoWDFOQTtRsAjRbr4AJJVlUQclLJsIpnP26sKVNXSuw542rBixu34A87xwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpTJaruZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpTJaruZ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f8095a200eso2050886a12.1
        for <linux-mmc@vger.kernel.org>; Sat, 16 Nov 2024 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771643; x=1732376443; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=UpTJaruZ4fXtGtnT9foMjSKpUZVJag/Vmq2JAe8UUBQbYAT8d+moThJ+Cjk+aqcv9b
         tpJUHlXn5L3/ZwgRv+DK80MH2ZCTsLEQc63uSTiYCQeFJom8tUD6/QVLcncnCNzTqesE
         +4UEWXEnWF1SP50b2yUDEhitReRAL4mO/k0Kvz2tC3Og1hODj85Wq+0sbsEF1FBFGXck
         h2eToasV6i1FB/DsEWmFIVIbKualpJ3B62jnR/FLc7esyQGSKHyyW9zqaacZuZdOO6BU
         /GVxpd/FFP6V76qDlTqO6gIvHCnqq9BdwVH8STM36NFuamiHjegIdP21fKzhwa5nKsyk
         F1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771643; x=1732376443;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=LU5x9k+owVZO7FowaKJPEXOcAO/psmKr3JzQHkXYW09uP/RVf8tnAy/9QEv1kHwbjw
         JfrHzy3gmUShj5F1zErxNCNYG2gUUOagp1fytI5jF0sMAWMgdskcRzgp4RIQsZKcpLjD
         kfVWJIqazBf0yGXxVcd8Nul2VWW7vGIf+Et+x/AHwfqP9+Z13NvO3wo1aRpt/VLIOYw7
         OXbOLowLLwicz/JMcuqmeY4oKH2t4ybnb8FFcYgH0wviTnnW0MHvMjOhCykikPf/ItDc
         dXfcPG9yQIY17ubvGdoD6qykG6Of5+6TZwJmKeP9Izh+Ur3K0KJvepSZ7zX6mcZfW4hR
         vTIw==
X-Gm-Message-State: AOJu0YwvIc3lGPM9Ps988Ae0oQ0CjsF/lcsmamB7PdLx1ddq8D9D7UY7
	M9BRkJFJTWzlqYXGJX3RFN1GsBICy62ErFYNjhpeBAc1MgpQep2fawkVTg==
X-Google-Smtp-Source: AGHT+IETFsB/E/AV+Uek4BWladZ9jlHrXRwAW0VdWFcckgZNAfNd9E9Q1u6LcKK6Roz5pF0XfWONfw==
X-Received: by 2002:a17:90b:250d:b0:2ea:28bc:8b55 with SMTP id 98e67ed59e1d1-2ea28bc8d6fmr6851347a91.9.1731771642978;
        Sat, 16 Nov 2024 07:40:42 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024ab569sm4666911a91.32.2024.11.16.07.40.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:41 -0800 (PST)
From: "Van. HR" <loneimtiyazahmad99@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <6c0274ba672044502a3e237cee6ab9940258d48cae2ec2803f1dfaf54a32ca76@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-mmc@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:38 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

