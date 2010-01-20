From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] s3cmci: Initialize default platform data no_wprotect
 and	no_detect with 1
Date: Wed, 20 Jan 2010 13:44:26 +0300
Message-ID: <4B56DE8A.70209@ru.mvista.com>
References: <1263975361-29376-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:3067 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752872Ab0ATKoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2010 05:44:54 -0500
In-Reply-To: <1263975361-29376-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

Lars-Peter Clausen wrote:

> If no platform_data was givin to the device it's going to use it's default
> platform data struct which has all fields initialized to zero.
> As a result the driver is going to try to request gpio0 both as write protect
> and card detect pin. Which of course will fail and makes the driver unusable
>
> Previously to the introduction of no_wprotect and no_detect the behavior was
> to assume that if no platform data was given there is no write protect or card
> detect pin.
> This patch restores that behavior.
>   

   The very idea of the default platform data seems dubious...

WBR, Sergei


