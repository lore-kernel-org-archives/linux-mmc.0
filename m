From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 3.7.0-rc4 0/4] introduce of_simple_module_id_table macro
Date: Tue, 20 Nov 2012 16:45:31 +0000
Message-ID: <20121120164531.8C8013E102F@localhost>
References: <1353072068-17758-1-git-send-email-srinivas.kandagatla@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33510 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2KTQpg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 11:45:36 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3670554wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Nov 2012 08:45:35 -0800 (PST)
In-Reply-To: <1353072068-17758-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: rob.herring@calxeda.com, viresh.linux@gmail.com, g.liakhovetski@gmx.de, ian@mnementh.co.uk, thomas.ab@samsung.com
Cc: srinivas.kandagatla@st.com, spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Fri, 16 Nov 2012 13:21:08 +0000, Srinivas KANDAGATLA <srinivas.kandagatla@st.com> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch series introduces of_simple_module_id_table macro and as an example
> uses this macro in 3 files.
> 
> Most of the device tree supported drivers have of_device_id table setup with 
> single compatible entry, this use-case is very simple and common.
> 
> #ifdef CONFIG_OF
> static struct of_device_id xxx_of_match[] = {
> 	{ .compatible = "yyy,zzz" },
> 	{ },
> };
> MODULE_DEVICE_TABLE(of, xxx_of_match);
> #endif
> 
> This patch adds a macro for this simple type of device table.
> Other subsystems like pm, platform, have similar macros in kernel for
> simplest cases.
> Now the user can just replace the above code with
> 
> of_simple_module_id_table(xxx_of_match, "yyy,zzz");
> 
> There are more than 200+ hits for this type of pattern in the current kernel.

While I like the reduction in lines of source code, I'm not so fond of
the form. There is no easy way to extend the syntax for multiple
entries and it doesn't cover the frequently present .data field. Can you
think of a way to do this that can take a variable number of table
entries?

g.

