From: Sascha Sommer <saschasommer@freenet.de>
Subject: Re: [PATCH 1/2] mmc-sdricoh_cs: Delete unnecessary variable
 initialisations in sdricoh_init_mmc()
Date: Sun, 21 Feb 2016 10:11:19 +0100
Message-ID: <20160221101119.7b0ef9aa@madeira.sommer.dynalias.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<5682F3AC.7050107@users.sourceforge.net>
	<5682F473.9040609@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5682F473.9040609@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-mmc@vger.kernel.org

Hello,

Am Tue, 29 Dec 2015 22:00:35 +0100
schrieb SF Markus Elfring <elfring@users.sourceforge.net>:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 29 Dec 2015 21:11:45 +0100
> 
> These variables will eventually be set to an appropriate value a bit
> later.
> * host
> * iobase
> * result
> 
> Thus let us omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Sascha Sommer <saschasommer@freenet.de>


Best regards

Sascha
