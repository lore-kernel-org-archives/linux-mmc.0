Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B4317173
	for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338734; cv=none; b=Y33AAg8tG776Z4MQB7z7faGjtJNFI24b4dYkftPIOsaa24u3NZvoVe6R9dYU5BM4HOCWjAzAFdPWg/3cn9abHenthRR8G01MiOPZv2pdJnLAjM8vy0x/h36TVn6UCRv3IrNJBCE3YZdI1DVocXk4k1VTODi/7YfCiW4oFh8S7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338734; c=relaxed/simple;
	bh=ZfRpG4oIxgjGKIrgZyLPJdJUHIheviJzeG7wU6lQzp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uezTLbMDKF8Dscm+hEGm2UuStGRhTvWZS3G52TJV1Zp4fqIcO/paIiOeI3sj1lNYMsilSyj59CtpMhZIz++LxcYbOZ+3I4+32NX/vVbieFEZpXLMDFhwpp/ZOPMffWJ/oczW61oDqShJhN2fpmaEnht1sjMapt3dX6g5EjgaB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrRZc73G; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrRZc73G"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e0688b859so336211b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338732; x=1787943532; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NOrDCUU4HChGMuUV8pMGy630hgv4NhLNIV6Jw05OoLQ=;
        b=KrRZc73Gl+EiHaEeKE7oiV/CnXDIfAstONEMHkMZwPjf6QNLqwvhp21zJH7uQRC/Lp
         F2zvrhi5y7kgaiGHC98iC98O+Rp6rZ/QDT9TN7zOMe3V0Mbto/AgTVF9zaH7HNaqDj7w
         /uhGrYpOH28PnTvwAEYoV6hrz1SlrxLfnbuXmHA8CytAPqQjsUrGIoCAWDWnv3dw67Uf
         m8RoDQpUr6TG/Y0R88/vjaKiTMNFiA2PIolLrj8yM8K9MtjxfZ5EWakkk76CoS9otSak
         U2vL7V6wUk8PU5Lv5cLkQAq/MPAGtt8kBiNVCfydoApGNSXtbaJY3Mj+VEh5uF6G+cIu
         XJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338732; x=1787943532;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NOrDCUU4HChGMuUV8pMGy630hgv4NhLNIV6Jw05OoLQ=;
        b=EImnfRdzHLQXUFnrJzP+PPkErGsJ+wFEdaRR411p5w+AInGRuLTSVUg6xcJHP8y5Gv
         usBoQ41nVa5j2FrDR/aTGohBowXxpFsh6FD1dqo1Fbu9qZAAsW7trnHD2vTbVoxWXoyh
         qG4DMmaYQTjIm4rO15zXT714aYtUw9WX2xOwv07hyS7glHQB4SzXpzlyDrYmcVfB7Kbd
         4p8v1TBUvS0kGqddQb6YA2Hdc4BC1WhoLBJL+yhKmrVbmdlL3c+fWIaneaaztUCzzGEJ
         yoEa9X8ei0Jff7+BrAaZetk7GNbBTFRpwOb7yXR5FZ48fNzoDSb8VmNvfNxKc6aK9ZU9
         4aUQ==
X-Gm-Message-State: AFuF++kGTaX16n+HO4Zi5Qh0+/79nZHlvAQGP7tRhaE9egdzl5Iscfse
	76qNQP0IN2nhrX0/sHdGPMEaou06KCw5gyFOuUkGQF27snMKalA23rNF
X-Gm-Gg: AR+sD11vp33jUZaUehkCGSylJ3/ciUwVRYkZV1fXl7WFwCpF/v0BhGOaEjDEaalKhXA
	3+im9Y3VsxnrttXksjyZS37vK/BJEJ4tYjxtHUZxuG/AVQwIbAWEC3QJAa+jnHUCKmxp6gQjGYS
	uHTUS2AdDU7rmh8dn9IUZ6brNxfZMUViQeEGMQuh3SNMn5OZO3oOUX4nLAGs+wnKXhpVwiPrTjl
	lscZRZaf/c+fM0q8Q0g0HLkHIDsPABWlZs94fe03PypGZD0cPjn6y9MNRi4h9BNBsf7dSc6wS+J
	wk0XOhOiQyB6Jydt6ufgm2bXAlREu8wsN+WoTDKwmavgiBVGOXEbkdWGYv+F5yRgHO/GrParbbz
	bFqvOQOHLHu2cWymHjocCGbMKC0bNn9TwJKllx5g4zlpP+2er6uDSXJaBVPJDbNC8D1ngfEVHze
	4DjgpJG4ROuZ4W73wGWEylZSFltteDZlvos0hYQsMsJFWLtRFcP0cUXeJMzZOJUIj8fk+xvr/m0
	K+YbI19u9K52/O8bGRwy8Y9n2jeKoBFooje71R5CXIUDhF+ka3XL/D3aSrscw==
X-Received: by 2002:a05:6a00:4098:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-8520b9460c1mr1114956b3a.4.1787338732358;
        Fri, 21 Aug 2026 11:58:52 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3389fcfsm3249913b3a.18.2026.08.21.11.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 11:58:51 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 22 Aug 2026 02:58:47 +0800
Subject: [PATCH] mmc: sdio_uart: fix xmit_fifo leak when the port table is
 full
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-sdio_uart-v1-1-2cf3b1352c35@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOafiGoC/yXM3QpAQBBA4VfRXNtak7+8iqS1OxgXaAcpeXeLy
 69O5wIhzyRQRRd4Olh4mQOSOAI7mnkgxS4YUGOuS0Qljpd2N35TptDoCmsz6lII/eqp5/N71c1
 v2buJ7PYO4L4f0rbu8m0AAAA=
X-Change-ID: 20260822-sdio_uart-a702d7cc5eb4
To: Ulf Hansson <ulfh@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787338729; l=1118;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=ZfRpG4oIxgjGKIrgZyLPJdJUHIheviJzeG7wU6lQzp4=;
 b=Vdgb0AHrLkx0MK8bay1lg1O38A2tu1QPyYb7qLBcQhTU4YUrB6vNKgYj1VIM8tWvHZKj5YTcc
 QxpSEWyRNS7CwN0IOm8++FUdX24B0Q32M6A55x5rt+/JKNA0WXCRHhM
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

sdio_uart_add_port() allocates the transmit fifo before claiming a
slot in sdio_uart_table[].  When all UART_NR slots are taken, it
returns -EBUSY with the fifo still allocated, but the probe error
path only kfree()s the port, leaking the transmit fifo.

Free the fifo in the failure path of sdio_uart_add_port() itself so
the function retains nothing on error.

Fixes: 8b197a5ce7a7 ("sdio_uart: Use kfifo instead of the messy circ stuff")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/mmc/core/sdio_uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 7fd5dedf3ac0..705163c42972 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -104,6 +104,9 @@ static int sdio_uart_add_port(struct sdio_uart_port *port)
 	}
 	spin_unlock(&sdio_uart_table_lock);
 
+	if (ret)
+		kfifo_free(&port->xmit_fifo);
+
 	return ret;
 }
 

---
base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
change-id: 20260822-sdio_uart-a702d7cc5eb4

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

