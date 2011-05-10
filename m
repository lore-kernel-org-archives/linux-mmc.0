From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
Date: Tue, 10 May 2011 15:59:48 +0400
Message-ID: <4DC928B4.2040101@ru.mvista.com>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33711 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab1EJMBa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2011 08:01:30 -0400
Received: by bwz15 with SMTP id 15so4762651bwz.19
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2011 05:01:29 -0700 (PDT)
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hello.

On 10-05-2011 0:11, Antonio Ospite wrote:

> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d)

    Need the summary of that commit cited too -- for the human readers.

> it correctly degenerates and returns NULL when the
> regulator framework is disabled.

> Signed-off-by: Antonio Ospite<ospite@studenti.unina.it>

WBR, Sergei
