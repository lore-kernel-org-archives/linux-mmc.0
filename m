Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD45435A8B
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125332; cv=none; b=ESMDJnuF0qaTWy1Oz0b8SEq0nQDUTFgv/K+1u7mujm+uw4XRPTTT+d2rXWAHXERyeOBAdxo55xJ9/QIh6amT7KQdXWwJI/etDPxqqEQkE+GPrwEZZg42ZeMR8zJMepLx78za6u2tVgCbE1YDhMKO6sqOUGivBwsQeVIm4TK2nfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125332; c=relaxed/simple;
	bh=Iz+Cr6Z0loakD/erjIMAsYt7hdgC2FopSJGK1uDAkvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=an4HUT5XtyfGy8bGx3x08d7jntkKn6xJ+kjVpuX82qMVxSaORZ8YmqN/TAD22cWyWdt9zbg4phpefC0CbBqt6X06HwIuw4uFnXdoT6h3AK5rNKZzh93+VvBGpuAbeGep4+tJmzIDYCX8coXjWEd7IKVG01DtWQXaITeTx/aLNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYN7yboU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYN7yboU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso6273255e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789125323; x=1789730123; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iz+Cr6Z0loakD/erjIMAsYt7hdgC2FopSJGK1uDAkvY=;
        b=nYN7yboUsoHcEc5nUsQJYuoDyEQomyfsb8Tmq/BkIeMnhsjnfGI5/HFz8r/AkTM3Wk
         fMb3iSNIdFWfFdih2MN+3IZwOqYCChkJgR7x2qVu41AHaRHp+HbuG6w2uZCfWSyVLP12
         Wm4B8Bs7UiZ5ga6mA8l7PJK0SZYVGPRsF+qvizWJohI8bXzpKbsHZ8PCGd7QhI7Iam53
         TpHP7p4Vv1QDl1AF6PNX9SetufiY9Tg7RhmcVieIPB+cq0nNySHFBH29t0rsjlmA+qMh
         ralwjmDFLS80fJ1XBeougI+7nia07lOrH96GP8WKTO5jrLFP4ReEhNzi39J1VQeuACyd
         frdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125323; x=1789730123;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iz+Cr6Z0loakD/erjIMAsYt7hdgC2FopSJGK1uDAkvY=;
        b=Ui79dy1mcK19+fquiPT63d/ooUn+1w7GIJ0vkUenUIh674fIt1JW+Iy9ONNzpTYw5S
         BdjlKMyWdlxxba7hE2s9RmaFxnaKJIDm9PhDoseyTo4J4NkvZsnBmjeozDxu1gm+uKiT
         OhGg/a0YknL1bT7Cf9Y2zUZhjlm6T+AHaisQJ4OqyuVwsg0MEDjD4e5pUy6ifVoS7Yii
         EJJuPH9Mbo/08kBLfd1DhwN3EA73HKemJ4q5+bt5GcauQa0pUWYwYwWQIgEUsk/1JfSh
         QgSj3aiXOdGdmKo0GNXBYsdUrR6e3zCKUeSAJk2XHIZup+8dZoUNHqjCRmyH512JMQhb
         0DMg==
X-Forwarded-Encrypted: i=1; AKwUvBxdcy9vWQrZB48+QekFEd96Oa5iPVJzd8dlxJFfAD/6yCm0Lc8bqPWudjLNwwwIQBzgg5cMUSIhMKk=@vger.kernel.org
X-Gm-Message-State: AFuF++l1cHvJSHSYLpXkZZnE8XLTNFk2V9GsvcmgS1dGsxTOFTLI6uEp
	JBbdzfvjvdOrvIBoxr9tglc9ngy7gCl1qQZMYUS0+cJL27zyxd1yiNo=
X-Gm-Gg: AYBFou0koIJyC5rE1usOj6YuXQri0n2fdtPkdKoRGL87rAjz6nvlx5tu8QJEQbTg2BH
	CUn+9th2QZZtQsNjqgxVnw2VG8y1PoR6ZTzd2m8A9EulPmou4A5aDVUqemD4AMdpENwbAAxKAi1
	9DhoFX/2XKJlGQhYU0NcDpTfsx4TuEYfNLcIl+t7Shl7OsNFeVApYodPEB9a8dQE69L7ufMer0i
	i0Pxxfm3R2YAGwvlAQy5RfiNsvH6tUt5pWiJTliixun5kJsbv0VXPe5CVxzYSx2jnQQaKtFejS2
	kn2y6Oggtis2O6q9sZoVv4rup686cjKn5mDxN9M/KTVuuZTV8QUdOUhXq7n9ZWUfdO3gdaVlDC0
	ZN3DmDU5WDaruV5FmLQjm8SR/UrmRgr1KN1zhSpD3gX74U/lQ/RF3eUw2xzkut4hteS4QXJpypS
	H5CSZ8xmVv07ZYkJiY/7h+cEtKXGLSfYBjWkUVmGCsw3YCudYVOCOiGsR69aLKOSWPVa16Nls7b
	LipDQluQ2as7FRzrZLKjVPv2jgEGPap/0N5EVdoJynVLRXPWIopEwR/O9HfnrQO7J4CIrHk6yb6
	nw4gf1jK6M6Q1cxP70DYxswsZc+GBfLbnjR6pAnVXnsyQv6F/7V6lO+0OTESscTBSBXLMNyH
X-Received: by 2002:a05:600c:4693:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49e619bec89mr78139215e9.6.1789125322522;
        Fri, 11 Sep 2026 04:15:22 -0700 (PDT)
Received: from localhost (92-242-249-81.broadband.mtnet.hr. [92.242.249.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecfc3sm5062381f8f.4.2026.09.11.04.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 04:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 13:14:20 +0200
Message-Id: <DLCFZ1Z5FV92.3JAXNVQWJZGN8@gmail.com>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Ulf Hansson"
 <ulfh@kernel.org>, "Jakov Novak" <jakovnovak30@gmail.com>,
 <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kernel-mentees@lists.linux.dev>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Runyu Xiao" <runyu.xiao@seu.edu.cn>, "Shuah
 Khan" <skhan@linuxfoundation.org>,
 <syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
From: "Jakov Novak" <jakovnovak30@gmail.com>
To: "Johan Hovold" <johan@kernel.org>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260816153809.7067-1-jakovnovak30@gmail.com>
 <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com>
 <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com> <aqGWWhvL5CKH2mgx@shikoro>
 <aqOoBwBav8JZhMQ9@hovoldconsulting.com>
In-Reply-To: <aqOoBwBav8JZhMQ9@hovoldconsulting.com>

Hi Johan,

> Thanks for taking a look. I guess we should fix this inconsistency in
> MMC core eventually, but that the vub300 needs to be reworked to handle
> this quirk in the mean time.

Should I send a v2 based on my first patch with the Reported-by,
Tested-by and Fixes tags fixed or is there something else I missed?=20

Best,
Jakov
